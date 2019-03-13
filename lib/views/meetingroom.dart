import 'package:flutter/material.dart';
import '../components/room_overview.dart';

class MeetingRoom extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new MeetingRoomState();
  }
}

class MeetingRoomState extends State<MeetingRoom>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: RoomOverview(),
          ),
        ],
      ),
    );
  }

}