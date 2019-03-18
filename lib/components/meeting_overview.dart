import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import '../utils/net_util.dart';
import '../model/meeting.dart';

class MeetingOverview extends StatefulWidget{
  int roomId;
  String roomName;
  
  MeetingOverview(this.roomId, this.roomName);
  
  @override
  State<StatefulWidget> createState() {
    return new MeetingOverviewState(roomId, roomName);
  }
}

class MeetingOverviewState extends State<MeetingOverview>{
  int roomId;
  String roomName;
  
  MeetingOverviewState(this.roomId, this.roomName);

  List<Meetings> meetingAll;
  List<Meetings> meetingList;

  @override
  void initState() {
    getContent();
    super.initState();
  }

  void getContent(){
    Map<String, dynamic> params = {"id": roomId};
    NetUitl.get(
      "/room/meetings",
      (data){
        Meeting rawData = Meeting.fromJson(data);
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
        if(meetingAll[i].startTime.substring(0, 10) == date)
          meetingList.add(meetingAll[i]);
      }
    });
  }

  void initMeetingList(String date){
    meetingList = new List();
    for(int i = 0; i < meetingAll.length; i++){
      if(meetingAll[i].startTime.substring(0, 10) == date)
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
      return Scaffold(
        appBar: AppBar(
          title: Text(roomName),
        ),
        body: Column(
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
        ),
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
        child: Text('暂无任何会议预约安排！'),
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
                  Text('时间：' + meeting.startTime.substring(11, 16) + '——' + meeting.endTime.substring(11, 16)),
                  Text('会议名称：' + meeting.name),
                  Text('会议主持人：' + meeting.leader.realName),
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