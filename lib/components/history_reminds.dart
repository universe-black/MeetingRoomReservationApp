import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import '../model/user_entity.dart';
import '../model/remind.dart';
import '../utils/net_util.dart';

class HistoryReminds extends StatefulWidget{
  User user;

  HistoryReminds(this.user);

  @override
  State<StatefulWidget> createState() {
    return new HistoryRemindsState(user);
  }
}

class HistoryRemindsState extends State<HistoryReminds>{
  User user;

  HistoryRemindsState(this.user);

  List<Reminds> reminds;

  List<Reminds> remindsOfDay;

  @override
  void initState() {
    getReminds();
    super.initState();
  }

  void getReminds(){
    NetUtil.getReminds((data){
      setState(() {
        reminds = Remind.fromJson(data).extras.reminds;
      });
    });
  }

  void setRemindsOfDay(String date){
    setState(() {
      remindsOfDay = new List();
      for(int i = 0; i < reminds.length; i++){
        if(reminds[i].time.substring(0, 10) == date)
          remindsOfDay.add(reminds[i]);
      }
    });
  }

  void initRemindsOfDay(String date){
    remindsOfDay = new List();
    for(int i = 0; i < reminds.length; i++){
      if(reminds[i].time.substring(0, 10) == date)
        remindsOfDay.add(reminds[i]);
    }
  }


  @override
  Widget build(BuildContext context) {
    if(reminds == null){
      return Scaffold(
        appBar: AppBar(
          title: Text("历史消息"),
        ),
        body: Center(child: CircularProgressIndicator(),),
      );
    }
    else{
      if(remindsOfDay == null){
        initRemindsOfDay(DateTime.now().toString().substring(0, 10));
      }
      return Scaffold(
        appBar: AppBar(
          title:  Text("历史消息"),
        ),
        body: Column(
          children: <Widget>[
            Calendar(
              onDateSelected: (date){
                setRemindsOfDay(date.toString().substring(0, 10));
              },
            ),
            Expanded(
              child: RemindsOfDay(list: remindsOfDay),
            ),
          ],
        ),
      );
    }
  }
}

class RemindsOfDay extends StatelessWidget{
  RemindsOfDay({this.list});

  final List<Reminds> list;

  @override
  Widget build(BuildContext context) {
    if(list.length != 0){
      return ListView(
        children: list.map((remind){
          return _buildTimeLine(remind);
        }).toList(),
      );
    }
    else
      return Center(
        child: Text('暂无任何消息通知！'),
      );
  }

  Widget _buildTimeLine(Reminds remind) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: Card(
            margin: EdgeInsets.all(20.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Align(
                    child: Text('发送时间：' + remind.time.substring(11, 16)),
                    alignment: Alignment.centerLeft,
                  ),
                  Align(
                    child: Text('会议名称：' + remind.meeting.name),
                    alignment: Alignment.centerLeft,
                  ),
                  Align(
                    child: Text('会议地点：' + remind.meeting.room.name),
                    alignment: Alignment.centerLeft,
                  ),
                  Align(
                    child: Text('会议主持人：' + remind.meeting.leader.realName),
                    alignment: Alignment.centerLeft,
                  ),
                  Align(
                    child: Text('消息内容：' + remind.content, style: TextStyle(color: Colors.blue),),
                    alignment: Alignment.centerLeft,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0.0,
          bottom: 0.0,
          left: 35.0,
          child: Container(
            height: double.infinity,
            width: 2.0,
            color: Colors.blue,
          ),
        ),
        Positioned(
          top: 13.0,
          left: 22.5,
          child: Container(
            height: 26.0,
            width: 26.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.lightBlue,
            ),
            child: Container(
              margin: EdgeInsets.all(5.0),
              height: 26.0,
              width: 26.0,
              decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}