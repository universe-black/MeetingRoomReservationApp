import 'package:flutter/material.dart';
import '../components/room_picker.dart';
import '../components/user_picker.dart';

class ReservationForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new ReservationFormState();
  }
}

class ReservationFormState extends State<ReservationForm>{
  String meetingDate = "";
  String meetingStartTime = "";
  String meetingEndTime = "";
  String meetingRoom = "";
  String meetingRoomId = "";
  bool roomOccupied = false;
  String isUserSelected = "未选择";
  List<String> selectedUsers = new List();
  String meetingName;
  String meetingDescription = "";
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          _buildDatePicker(),
          _buildStartTimePicker(),
          _buildEndTimePicker(),
          _buildLocationPicker(),
          _buildUserPicker(),
          _buildNameText(),
          _buildDescriptionText(),
          _buildSubmit(),
        ],
      ),
    );
  }

  Widget _buildDatePicker(){
    return GestureDetector(
      onTap: (){
        showDatePicker(
          context: context,
          initialDate: new DateTime.now(),
          firstDate: new DateTime.now().subtract(new Duration(days: 30)),
          lastDate: new DateTime.now().add(new Duration(days: 30)),
        ).then((DateTime val){
          setState(() {
            meetingDate = val.toString().substring(0, 10);
          });
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[350],
        ),
        padding: EdgeInsets.only(left: 10, top: 18, bottom: 18, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("会议日期：$meetingDate", style: TextStyle(fontSize: 16)),
            Row(
              children: <Widget>[
                Text("选择日期", style: TextStyle(fontSize: 12)),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStartTimePicker(){
    return GestureDetector(
      onTap: (){
        showTimePicker(
          context: context,
          initialTime: meetingStartTime == "" ? new TimeOfDay.now() : TimeOfDay(hour: int.parse(meetingStartTime.substring(0, 2)), minute: int.parse(meetingStartTime.substring(3))),
        ).then((val){
          setState(() {
            meetingStartTime = val.format(context);
          });
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        padding: EdgeInsets.only(left: 10, top: 18, bottom: 18, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("会议开始时间：$meetingStartTime", style: TextStyle(fontSize: 16)),
            Row(
              children: <Widget>[
                Text("选择开始时间", style: TextStyle(fontSize: 12)),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEndTimePicker(){
    return GestureDetector(
      onTap: (){
        showTimePicker(
          context: context,
          initialTime: meetingEndTime == "" ? new TimeOfDay.now() : TimeOfDay(hour: int.parse(meetingEndTime.substring(0, 2)), minute: int.parse(meetingEndTime.substring(3))),
        ).then((val){
          setState(() {
            meetingEndTime = val.format(context);
          });
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[350],
        ),
        padding: EdgeInsets.only(left: 10, top: 18, bottom: 18, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("会议结束时间：$meetingEndTime", style: TextStyle(fontSize: 16)),
            Row(
              children: <Widget>[
                Text("选择结束时间", style: TextStyle(fontSize: 12)),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationPicker(){
    return GestureDetector(
      onTap: (){
        if(meetingDate != "" && meetingStartTime != "" && meetingEndTime != ""){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context){
                return RoomPicker(meetingDate, meetingStartTime, meetingEndTime);
              })
          ).then((result){
            if(result != null){
              setState(() {
                meetingRoomId = result[0];
                meetingRoom = result[1];
                roomOccupied = result[2];
                print(meetingRoomId + "——" + meetingRoom + " 是否冲突：" + roomOccupied.toString());
              });
            }
          });
        }
        else{
          showDialog(
            context: context,
            //barrierDismissible: false,
            builder: (BuildContext context){
              return AlertDialog(
                title: Text("会议时间段未确定！"),
                content: Text("请选择好会议时间段，\n以便更好地选择会议地点。"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("确定"),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        padding: EdgeInsets.only(left: 10, top: 18, bottom: 18, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("会议地点：$meetingRoom", style: TextStyle(fontSize: 16)),
            Row(
              children: <Widget>[
                Text("选择会议地点", style: TextStyle(fontSize: 12)),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserPicker(){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context){
            return UserPicker(selectedUsers);
          }),
        ).then((value){
          if(value != null){
            selectedUsers = value;
            if(selectedUsers.length != 0)
              isUserSelected = "已选择";
            else
              isUserSelected = "未选择";
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[350],
        ),
        padding: EdgeInsets.only(left: 10, top: 18, bottom: 18, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("与会人员：$isUserSelected", style: TextStyle(fontSize: 16)),
            Row(
              children: <Widget>[
                Text("选择与会人员", style: TextStyle(fontSize: 12)),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameText(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        maxLength: 16,
        decoration: InputDecoration(labelText: "会议名称"),
        onSaved: (val) => meetingName = val,
        validator: (val){
          if(val.isEmpty){
            return "请输入会议名称";
          }
        },
      ),
    );
  }

  Widget _buildDescriptionText(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[350],
      ),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        maxLength: 150,
        decoration: InputDecoration(labelText: "会议概述(可填)"),
        onSaved: (val) => meetingDescription = val,
      ),
    );
  }

  Widget _buildSubmit(){
    return RawMaterialButton(
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
          Text("提交会议申请", style: TextStyle(color: Colors.white),),
          Icon(Icons.arrow_back_ios, color: Colors.white, size: 14),
        ],
      ),
      onPressed: submitAction,
      fillColor: Theme.of(context).primaryColor,
    );
  }

  void submitAction(){
    final form = _formKey.currentState;
    if(form.validate()) {
      form.save();
      if(meetingRoomId == ""){
        showDialog(context: context, builder: (ctx) => _getAlertDialog("未选择会议地点", "请选择会议地点！"));
      }
      else if(selectedUsers.length == 0){
        showDialog(context: context, builder: (ctx) => _getAlertDialog("未选择与会人员", "请选择与会人员！"));
      }
      else{
        String notice = "无";
        if(roomOccupied){
          notice = "所申请的会议时间存在冲突,必要时请联系管理员协商。";
        }
        showDialog(context: context, builder: (ctx) => _getAlertDialog("确认事项",
                "会议日期：$meetingDate\n"
                "会议时间：$meetingStartTime——$meetingEndTime\n"
                "会议地点：$meetingRoom\n"
                "注意事项：" + notice,
            submit: "提交会议申请")
        );
      }
    }
  }

  Widget _getAlertDialog(String title, String content, {String submit}){
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: submit == null ? <Widget>[
        FlatButton(
          child: Text("确定"),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ] : <Widget>[
        FlatButton(
          child: Text("取消"),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(submit),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}