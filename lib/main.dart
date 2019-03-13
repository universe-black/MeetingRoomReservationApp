import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:badges/badges.dart';
import './views/schedule.dart';
import './views/meetingroom.dart';
import './views/appointment.dart';
import './views/user_drawer.dart';

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
      home: MyHomePage(),
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
