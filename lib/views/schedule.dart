import 'package:flutter/material.dart';
import '../components/schedule_overview.dart';

class Schedule extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new ScheduleState();
  }
}

class ScheduleState extends State<Schedule>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ScheduleOverview(1),
    );
  }
}