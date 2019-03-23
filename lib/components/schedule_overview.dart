import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import '../utils/net_util.dart';
import '../model/user_meeting.dart';

class ScheduleOverview extends StatefulWidget{
  int userId;

  ScheduleOverview(this.userId);

  @override
  State<StatefulWidget> createState() {
    return new ScheduleOverviewState(userId);
  }
}

class ScheduleOverviewState extends State<ScheduleOverview>{
  int userId;

  ScheduleOverviewState(this.userId);

  List<Meetings> meetingAll;
  List<Meetings> meetingList;

  @override
  void initState() {
    getContent();
    super.initState();
  }

  void getContent(){
    Map<String, dynamic> params = {"id": userId};
    NetUtil.get(
      "/user/meetings",
      (data){
        UserMeeting rawData = UserMeeting.fromJson(data);
        setState(() {
          meetingAll = rawData.extras.meetings;
        });
      },
      params,
    );
  }

  void setMeetingList(String date){
    setState(() {
      meetingList = new List();
      for(int i = 0; i < meetingAll.length; i++){
        if(meetingAll[i].startTime.substring(0, 10) == date && meetingAll[i].state != null)
          if(meetingAll[i].state >= 1 && meetingAll[i].state <= 3)
            meetingList.add(meetingAll[i]);
      }
    });
  }

  void initMeetingList(String date){
    meetingList = new List();
    for(int i = 0; i < meetingAll.length; i++){
      if(meetingAll[i].startTime.substring(0, 10) == date && meetingAll[i].state != null)
        if(meetingAll[i].state >= 1 && meetingAll[i].state <= 3)
          meetingList.add(meetingAll[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    if(meetingAll == null){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    else{
      if(meetingList == null){
        initMeetingList(DateTime.now().toString().substring(0, 10));
      }
      return Column(
        children: <Widget>[
          Calendar(
            onDateSelected: (date){
              setMeetingList(date.toString().substring(0, 10));
            },
          ),
          Expanded(
            child: MeetingOfDay(list: meetingList),
          ),
        ],
      );
    }
  }
}

class MeetingOfDay extends StatelessWidget{
  MeetingOfDay({this.list});

  final List<Meetings> list;

  @override
  Widget build(BuildContext context) {
    if(list.length != 0){
      return ListView(
        children: list.map((meeting){
          return _buildTimeLine(meeting);
        }).toList(),
      );
    }
    else
      return Center(
        child: Text('暂无任何会议安排！'),
      );
  }

  Widget _buildTimeLine(Meetings meeting) {
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
                    child: Text('时间：' + meeting.startTime.substring(11, 16) + '——' + meeting.endTime.substring(11, 16), style: TextStyle(color: Colors.blue),),
                    alignment: Alignment.centerLeft,
                  ),
                  Align(
                    child: Text('会议地点：' + meeting.room.name, style: TextStyle(color: Colors.blue),),
                    alignment: Alignment.centerLeft,
                  ),
                  Align(
                    child: Text('会议名称：' + meeting.name),
                    alignment: Alignment.centerLeft,
                  ),
                  Align(
                    child: Text('会议主持人：' + meeting.leader.realName),
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
              color: Colors.lightGreen,
            ),
            child: Container(
              margin: EdgeInsets.all(5.0),
              height: 26.0,
              width: 26.0,
              decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.red[400]),
            ),
          ),
        )
      ],
    );
  }
}