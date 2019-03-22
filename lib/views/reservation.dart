import 'package:flutter/material.dart';
import '../components/reservation_form.dart';

class Reservation extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new ReservationState();
  }
}

class ReservationState extends State<Reservation>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: ReservationForm(),
      ),
    );
  }

}