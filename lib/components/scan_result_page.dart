import 'package:flutter/material.dart';

class ScanResult extends StatefulWidget{
  String result;

  ScanResult(this.result);

  @override
  State<StatefulWidget> createState() {
    return new ScanResultState(result);
  }
}

class ScanResultState extends State<ScanResult>{
  String result;

  ScanResultState(this.result);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("扫描结果"),
      ),
      body: Center(
        child: Text(result),
      ),
    );
  }
}