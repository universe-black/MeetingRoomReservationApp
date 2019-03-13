import 'package:flutter/material.dart';

class Appointment extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new AppointmentState();
  }
}

class AppointmentState extends State<Appointment>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Text('会议预约'),
      ),
    );
  }

}