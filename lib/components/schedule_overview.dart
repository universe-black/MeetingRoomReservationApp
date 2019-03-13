import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';

class ScheduleOverview extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new ScheduleOverviewState();
  }
}

class ScheduleOverviewState extends State<ScheduleOverview>{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Calendar(

        ),
      ],
    );
  }
}