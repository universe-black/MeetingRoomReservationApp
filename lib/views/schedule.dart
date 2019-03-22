import 'package:flutter/material.dart';
import '../components/schedule_overview.dart';

class Schedule extends StatefulWidget{
  int userId;

  Schedule(this.userId);

  @override
  State<StatefulWidget> createState() {
    return new ScheduleState(userId);
  }
}

class ScheduleState extends State<Schedule>{
  int userId;

  ScheduleState(this.userId);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ScheduleOverview(userId),
    );
  }
}