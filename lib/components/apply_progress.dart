import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import '../components/reservation_form.dart';
import '../utils/net_util.dart';
import '../model/user_meeting.dart';

class ApplyProgress extends StatefulWidget{
  int userId;

  ApplyProgress(this.userId);

  @override
  State<StatefulWidget> createState() {
    return new ApplyProgressState(userId);
  }
}

class ApplyProgressState extends State<ApplyProgress>{
  int userId;

  ApplyProgressState(this.userId);

  List<Meetings> meetingList;
  List<Meetings> reservation;
  List<Meetings> reservationOfDay;

  @override
  void initState() {
    super.initState();
    getContent();
  }

  void setList(){
    setState(() {
      reservation = new List();
      for(Meetings e in meetingList){
        if(e.leader.id == userId){
          reservation.add(e);
        }
      }
    });
  }

  void getContent(){
    Map<String, dynamic> params = {"id": userId};
    NetUtil.get(
      "/user/meetings",
          (data){
        UserMeeting rawData = UserMeeting.fromJson(data);
        setState(() {
          meetingList = rawData.extras.meetings;
        });
        setList();
      },
      params,
    );
  }

  void setReservationOfDay(String date){
    setState(() {
      reservationOfDay = new List();
      for(int i = 0; i < reservation.length; i++){
        if(reservation[i].startTime.substring(0, 10) == date)
          reservationOfDay.add(reservation[i]);
      }
    });
  }

  void initReservationOfDay(String date){
    reservationOfDay = new List();
    for(int i = 0; i < reservation.length; i++){
      if(reservation[i].startTime.substring(0, 10) == date)
        reservationOfDay.add(reservation[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    if(reservation == null){
      return Scaffold(
        appBar: AppBar(
          title: Text("会议申请进度"),
        ),
        body: Center(child: CircularProgressIndicator(),),
      );
    }
    else{
      if(reservationOfDay == null){
        initReservationOfDay(DateTime.now().toString().substring(0, 10));
      }
      return Scaffold(
        appBar: AppBar(
          title: Text("会议申请进度"),
        ),
        body: Column(
          children: <Widget>[
            Calendar(
              onDateSelected: (date){
                setReservationOfDay(date.toString().substring(0, 10));
              },
            ),
            Expanded(
              child: ReservationOfDay(list: reservationOfDay),
            ),
          ],
        ),
      );
    }

  }
}

class ReservationOfDay extends StatelessWidget{
  ReservationOfDay({this.list});

  final List<Meetings> list;

  Widget _buildProgressCard(int stateNumber, Meetings meeting, BuildContext context){
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text("会议ID：" + meeting.id.toString(), style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
            _buildProgressBar(stateNumber, context),
            Container(
              width: double.infinity,
              height: 2.0,
              color: Colors.blue,
            ),
            Center(
              child: stateNumber <= 1 ? GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context){
                        return ReservationForm(typeCode: 2, meeting: meeting);
                      })
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("修改会议申请", style: TextStyle(fontSize: 14, color: Colors.green),),
                    Icon(Icons.arrow_forward_ios, size: 18, color: Colors.green),
                  ],
                ),
              ) : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("会议申请不可修改", style: TextStyle(fontSize: 14, color: Colors.grey),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(int stateNumber, BuildContext context){
    if(stateNumber == 5){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildStatePoint("已过期", context, color: Colors.grey),
          _buildStatePoint("已过期", context, color: Colors.grey),
          _buildStatePoint("已过期", context, color: Colors.grey),
          _buildStatePoint("已过期", context, color: Colors.grey),
        ],
      );
    }
    else if(stateNumber == 4){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildStatePoint("审核中", context),
          _buildStatePoint("未通过", context, color: Colors.red),
          _buildStatePoint("进行中", context, color: Colors.grey),
          _buildStatePoint("已结束", context, color: Colors.grey),
        ],
      );
    }
    else if(stateNumber == 3){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildStatePoint("审核中", context),
          _buildStatePoint("已通过", context),
          _buildStatePoint("进行中", context),
          _buildStatePoint("已结束", context, color: Colors.green),
        ],
      );
    }
    else if(stateNumber == 2){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildStatePoint("审核中", context),
          _buildStatePoint("已通过", context),
          _buildStatePoint("进行中", context, color: Colors.green),
          _buildStatePoint("已结束", context, color: Colors.grey),
        ],
      );
    }
    else if(stateNumber == 1){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildStatePoint("审核中", context),
          _buildStatePoint("已通过", context, color: Colors.green),
          _buildStatePoint("进行中", context, color: Colors.grey),
          _buildStatePoint("已结束", context, color: Colors.grey),
        ],
      );
    }
    else{
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildStatePoint("审核中", context, color: Colors.green),
          _buildStatePoint("已通过", context, color: Colors.grey),
          _buildStatePoint("进行中", context, color: Colors.grey),
          _buildStatePoint("已结束", context, color: Colors.grey),
        ],
      );
    }
  }

  Widget _buildStatePoint(String state, BuildContext context, {Color color}){
    if(color == null){
      return Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Card(
              margin: EdgeInsets.all(5.0),
              child: Container(
                padding: EdgeInsets.all(5),
                child: Text(state, style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),),
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 18,
            child: Icon(Icons.room, color: Theme.of(context).primaryColor, size: 32,),
          )
        ],
      );
    }
    else{
      return Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Card(
              margin: EdgeInsets.all(5.0),
              child: Container(
                padding: EdgeInsets.all(5),
                child: Text(state, style: TextStyle(fontSize: 16, color: color),),
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 18,
            child: Icon(Icons.room, color: color, size: 32,),
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if(list.length != 0){
      return ListView(
        children: list.map((meeting){
          return _buildTimeLine(meeting.state, meeting, context);
        }).toList(),
      );
    }
    else
      return Center(
        child: Text('暂无任何消息通知！'),
      );
  }

  Widget _buildTimeLine(int stateNumber, Meetings meeting, BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: _buildProgressCard(stateNumber, meeting, context),
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