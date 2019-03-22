import 'package:flutter/material.dart';
import '../components/room_overview.dart';

class RoomPicker extends StatefulWidget{
  String date;
  String startTime;
  String endTime;

  RoomPicker(this.date, this.startTime, this.endTime);

  @override
  State<StatefulWidget> createState() {
    return new RoomPickerState(date, startTime, endTime);
  }
}

class RoomPickerState extends State<RoomPicker>{
  String date;
  String startTime;
  String endTime;

  RoomPickerState(this.date, this.startTime, this.endTime);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("会议室选择"),
      ),
      body: RoomOverview(1, startTime: date + " " + startTime + ":00", endTime: date + " " + endTime + ":00",),
    );
  }
}