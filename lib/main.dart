import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:badges/badges.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './views/schedule.dart';
import './views/meetingroom.dart';
import './views/reservation.dart';
import './views/login.dart';
import './components/user_drawer.dart';
import './components/scan_result_page.dart';
import './components/meeting_overview.dart';
import './utils/net_util.dart';
import './utils/tip_util.dart';
import './model/user_entity.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '会议室预约系统',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(body1: TextStyle(fontSize: 14), body2: TextStyle(fontSize: 14)),
        appBarTheme: AppBarTheme(textTheme: TextTheme(title: TextStyle(fontSize: 18))),
        inputDecorationTheme: InputDecorationTheme(labelStyle: TextStyle(fontSize: 14), ),
        dialogTheme: DialogTheme(contentTextStyle: TextStyle(fontSize: 14, color: Colors.black)),
        primaryTextTheme: TextTheme(display1: TextStyle(fontSize: 20)),
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
  Future<bool> doubleClickBack() {
    int last = 0;
    int now = DateTime.now().millisecond;
    if (now - last < 500) {
      last = DateTime.now().millisecond;
      TipUtil.showTip("再按一次退出应用");
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  User user;
  int remindsNumber = 0;

  int _currentIndex = 0;
  final List<String> _names = ['我的安排', '会议室', '会议预约'];
  final List<Widget> _fragments = [
    Center(child: CircularProgressIndicator(),),
    MeetingRoom(),
    Reservation(),
  ];

  void setCount(int value) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.getInt("remindsNumber") == null){
      preferences.setInt("remindsNumber", 0);
    }
    setState(() {
      remindsNumber = preferences.getInt("remindsNumber");
    });
    preferences.setInt("remindsNumber", remindsNumber + value);
    setState(() {
      remindsNumber = preferences.getInt("remindsNumber");
    });
  }

  @override
  void initState() {
    super.initState();
    NetUtil.getUser((data){
      setState(() {
        user = UserEntity.fromJson(data).extras.user;
        _fragments[0] = Schedule(user.id);
      });
    });
    Timer.periodic(Duration(seconds: 1), (timer){
      NetUtil.getUnreadReminds((val){
        if(val != -1)
          setCount(val);
        else
          timer.cancel();
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
      RegExp regExp = new RegExp(r"^(\d+)\s\d\d-\d\d\d\s");
      if(regExp.hasMatch(barcode)){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context){
            return MeetingOverview(int.parse(barcode.split(" ")[0]), barcode.split(" ")[1]);
          }),
        );
      }
      else{
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context){
            return ScanResult(barcode);
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
    return new WillPopScope(
      onWillPop: doubleClickBack,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_names[_currentIndex]),
          leading: Builder(
            builder: (BuildContext context){
              return BadgeIconButton(
                itemCount: remindsNumber,
                icon: Icon(Icons.menu, color: Colors.white, size: 35,),
                onPressed: (){
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.center_focus_strong, color: Colors.white, size: 30,),
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
    var _duration = new Duration(milliseconds: 1500);
    return new Timer(_duration,toGo);
  }

  void toGo(){
    NetUtil.getUser((data){
      User user = UserEntity.fromJson(data).extras.user;
      if(user != null) {
        Navigator.of(context).pushReplacementNamed('/home');
        TipUtil.showTip("欢迎回来，" + user.realName);
      }
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
    return Image.asset('images/splash.gif', fit: BoxFit.fill,);
  }

}
