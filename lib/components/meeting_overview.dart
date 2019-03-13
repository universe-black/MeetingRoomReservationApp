import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import '../model/location.dart';
import '../model/meeting.dart';

class MeetingOverview extends StatefulWidget{
  final Room room;
  
  MeetingOverview(this.room);
  
  @override
  State<StatefulWidget> createState() {
    return new MeetingOverviewState(room);
  }
}

class MeetingOverviewState extends State<MeetingOverview>{
  final Room room;
  List<Meeting> meetingList;
  
  MeetingOverviewState(this.room);
  
  void setMeetingList(String date){
    setState(() {
      meetingList = new List();
      for(int i = 0; i < room.meetings.length; i++){
        if(Meeting.fromJson(room.meetings[i]).start_time.substring(0, 10) == date)
          meetingList.add(Meeting.fromJson(room.meetings[i]));
      }
    });
  }

  void initMeetingList(String date){
    meetingList = new List();
    for(int i = 0; i < room.meetings.length; i++){
      if(Meeting.fromJson(room.meetings[i]).start_time.substring(0, 10) == date)
        meetingList.add(Meeting.fromJson(room.meetings[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    if(meetingList == null){
      initMeetingList(DateTime.now().toString().substring(0, 10));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(room.room_number),
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

class MeetingOfDay extends StatelessWidget{
  MeetingOfDay({this.list});

  final List<Meeting> list;

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

  Widget _buildTimeLine(Meeting meeting) {
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
                  Text('时间：' + meeting.start_time.substring(11) + '——' + meeting.end_time.substring(11)),
                  Text('会议名称：' + meeting.meeting_name),
                  Text('会议主持人：' + meeting.holder),
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