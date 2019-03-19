import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:badges/badges.dart';
import './views/schedule.dart';
import './views/meetingroom.dart';
import './views/reservation.dart';
import 'package:meeting/components/user_drawer.dart';

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
  int _currentIndex = 0;
  final List<String> _names = ['我的安排', '会议室', '会议预约'];
  final List<Widget> _fragments = [
    Schedule(),
    MeetingRoom(),
    Appointment(),
  ];

  void _onTapHandler(int index){
    setState(() {
      _currentIndex = index;
    });
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
            tooltip: 'ScanFace',
            onPressed: null,
          ),
        ],
      ),
      drawer: new UserDrawer(),
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
    Navigator.of(context).pushReplacementNamed('/home');
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
