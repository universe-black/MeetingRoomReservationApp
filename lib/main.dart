import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:badges/badges.dart';
import 'package:barcode_scan/barcode_scan.dart';
import './views/schedule.dart';
import './views/meetingroom.dart';
import './views/reservation.dart';
import './views/login.dart';
import './components/user_drawer.dart';
import './components/scan_result_page.dart';
import './components/meeting_overview.dart';
import './utils/net_util.dart';
import './model/user_entity.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '会议室预约系统',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new Login(),
        '/home': (BuildContext context) => new MyHomePage(),
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh','CH'),
        const Locale('en','US'),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage>{
  User user;

  int _currentIndex = 0;
  final List<String> _names = ['我的安排', '会议室', '会议预约'];
  final List<Widget> _fragments = [
    Center(child: CircularProgressIndicator(),),
    MeetingRoom(),
    Reservation(),
  ];

  @override
  void initState() {
    super.initState();
    NetUtil.getUser((data){
      setState(() {
        user = UserEntity.fromJson(data).extras.user;
        _fragments[0] = Schedule(user.id);
      });
    });
  }

  void _onTapHandler(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      if(barcode.split(" ").length != 2){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context){
            return ScanResult(barcode);
          }),
        );
      }
      else{
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context){
            return MeetingOverview(int.parse(barcode.split(" ")[0]), barcode.split(" ")[1]);
          }),
        );
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        showDialog(context: context, builder: (ctx) => AlertDialog(
          title: Text("没有权限"),
          content: Text('用户没有授予摄像头权限，\n请于手机设置中调整！'),
          actions: <Widget>[
            FlatButton(
              child: Text("确定"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        ));
        Navigator.of(context).pop();
      } else {
        showDialog(context: context, builder: (ctx) => AlertDialog(
          title: Text("未知错误"),
          content: Text('Unknown error: $e'),
          actions: <Widget>[
            FlatButton(
              child: Text("确定"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        ));
        Navigator.of(context).pop();
      }
    } on FormatException{
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){return MyHomePage();}), (route) => route == null);
    } catch (e) {
      showDialog(context: context, builder: (ctx) => AlertDialog(
        title: Text("未知错误"),
        content: Text('Unknown error: $e'),
        actions: <Widget>[
         FlatButton(
           child: Text("确定"),
           onPressed: (){
             Navigator.of(context).pop();
           },
         )
        ],
      ));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(_names[_currentIndex]),
        leading: Builder(
          builder: (BuildContext context){
            return BadgeIconButton(
              itemCount: 9,
              icon: Icon(Icons.menu, color: Colors.white, size: 35,),
              onPressed: (){
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.center_focus_weak, color: Colors.white,),
            onPressed: scan,
          ),
        ],
      ),
      drawer: user == null ? null : UserDrawer(user),
      body: _fragments[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTapHandler,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range),
            title: Text('我的安排'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            title: Text('会议室'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm_add),
            title: Text('会议预约'),
          ),
        ],
      ),
    );
  }
}

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new SplashScreenState();
  }

}

class SplashScreenState extends State<SplashScreen>{
  startTime() async{
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration,toGo);
  }

  void toGo(){
    NetUtil.getUser((data){
      User user = UserEntity.fromJson(data).extras.user;
      if(user != null)
        Navigator.of(context).pushReplacementNamed('/home');
      else
        Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('images/splash.png'),
      ),
    );
  }

}
