import 'package:flutter/material.dart';
import '../components/room_picker.dart';
import '../components/user_picker.dart';
import '../components/apply_progress.dart';
import '../model/user_entity.dart';
import '../model/user_meeting.dart';
import '../utils/net_util.dart';

class ReservationForm extends StatefulWidget{
  int typeCode;
  int roomId;
  String roomName;
  Meetings meeting;

  ReservationForm({this.typeCode,this.roomId, this.roomName, this.meeting});

  @override
  State<StatefulWidget> createState() {
    if(typeCode == 1 && roomId != null && roomName != null)
      return new ReservationFormState(typeCode: typeCode, meetingRoomId: roomId.toString(), meetingRoom: roomName);
    else if(typeCode == 2 && meeting != null)
      return new ReservationFormState(typeCode: typeCode, meeting: meeting);
    else
      return new ReservationFormState();
  }
}

class ReservationFormState extends State<ReservationForm>{
  String leaderId;
  String meetingDate = "";
  String meetingStartTime = "";
  String meetingEndTime = "";
  String meetingRoom;
  String meetingRoomId;
  bool roomOccupied;
  String isUserSelected = "未选择";
  List<String> selectedUsers = new List();
  String meetingName;
  String meetingDescription = "";
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  int typeCode;
  Meetings meeting;
  ReservationFormState({this.typeCode, this.meetingRoomId, this.meetingRoom, this.meeting});

  @override
  void initState() {
    super.initState();
    NetUtil.getUser((data) {
      User user = UserEntity.fromJson(data).extras.user;
      setState(() {
        leaderId = user.id.toString();
        selectedUsers.add(leaderId);
      });
    });
    if(typeCode == 2)
      initForm();
  }

  void initForm(){
    setState(() {
      meetingDate = meeting.startTime.substring(0, 10);
      meetingStartTime = meeting.startTime.substring(11, 16);
      meetingEndTime = meeting.endTime.substring(11, 16);
      meetingRoomId = meeting.room.id.toString();
      meetingRoom = meeting.room.name;
      meetingName = meeting.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(typeCode == 1){
      return Scaffold(
        appBar: AppBar(
          title: Text("新增会议申请"),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildDatePicker(),
              _buildStartTimePicker(),
              _buildEndTimePicker(),
              _buildLocationView(),
              _buildUserPicker(),
              _buildNameText(),
              _buildDescriptionText(),
              _buildSubmit(),
            ],
          ),
        ),
      );
    }
    else if(typeCode == 2){
      return Scaffold(
        appBar: AppBar(
          title: Text("修改会议申请"),
        ),
        body: Form(
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
        ),
      );
    }
    else {
      if(meetingRoom == null && meetingRoomId == null){
        meetingRoom = "";
        meetingRoomId = "";
      }
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
  }

  Widget _buildDatePicker(){
    return GestureDetector(
      onTap: (){
        showDatePicker(
          context: context,
          initialDate: meetingDate == "" ? new DateTime.now().add(new Duration(days: 1)) : DateTime.parse(meetingDate),
          firstDate: new DateTime.now().subtract(new Duration(days: 1)),
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
        padding: EdgeInsets.only(left: 10, top: 16, bottom: 16, right: 20),
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
          if((meetingDate + val.toString()).compareTo(DateTime.now().toString().substring(0, 10) + TimeOfDay.now().toString()) > 0){
            setState(() {
              meetingStartTime = val.format(context);
            });
          }
          else{
            showDialog(context: context, builder: (ctx) => _getAlertDialog("会议开始时间已过", "请选择合适的会议开始时间！"));
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        padding: EdgeInsets.only(left: 10, top: 16, bottom: 16, right: 20),
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
          initialTime: meetingEndTime == "" ? TimeOfDay(hour: int.parse(meetingStartTime.substring(0, 2)), minute: int.parse(meetingStartTime.substring(3))) : TimeOfDay(hour: int.parse(meetingEndTime.substring(0, 2)), minute: int.parse(meetingEndTime.substring(3))),
        ).then((val){
          if(val.toString().compareTo(TimeOfDay(hour: int.parse(meetingStartTime.substring(0, 2)), minute: int.parse(meetingStartTime.substring(3))).toString()) <= 0){
            showDialog(context: context, builder: (ctx) => _getAlertDialog("错误的会议结束时间", "会议结束时间应在会议开始时间之后！"));
          }
          else{
            setState(() {
              meetingEndTime = val.format(context);
            });
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[350],
        ),
        padding: EdgeInsets.only(left: 10, top: 16, bottom: 16, right: 20),
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

  Widget _buildLocationView(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      padding: EdgeInsets.only(left: 10, top: 16, bottom: 16, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("会议地点：$meetingRoom", style: TextStyle(fontSize: 16)),
          Row(
            children: <Widget>[
              Text("会议地点已选定", style: TextStyle(fontSize: 12)),
              Icon(Icons.check)
            ],
          ),
        ],
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
        padding: EdgeInsets.only(left: 10, top: 16, bottom: 16, right: 20),
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
            if(selectedUsers.length > 1)
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
        padding: EdgeInsets.only(left: 10, top: 16, bottom: 16, right: 20),
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
      if(meetingDate == "" || meetingStartTime == "" || meetingEndTime == ""){
        showDialog(context: context, builder: (ctx) => _getAlertDialog("未选择会议时间", "请选择会议时间！"));
      }
      else if(meetingRoomId == ""){
        showDialog(context: context, builder: (ctx) => _getAlertDialog("未选择会议地点", "请选择会议地点！"));
      }
      else if(selectedUsers.length == 0){
        showDialog(context: context, builder: (ctx) => _getAlertDialog("未选择与会人员", "请选择与会人员！"));
      }
      else{
        String notice = "无";
        if(roomOccupied == true){
          notice = "\n所申请的会议时间存在冲突，可能无法提交申请，必要时请联系管理员协商。";
        }
        else if(roomOccupied == null){
          notice = "\n请确认预约时间同该会议室的安排无冲突，否则可能无法提交申请。";
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
            if(typeCode != 2){
              NetUtil.sendApplication(_generateMeetingInfo(), _generateUserInfo(), (val){
                if(val == true){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context){
                      return ApplyProgress(int.parse(leaderId));
                    }),
                  );
                }
              });
            }
            else{
              NetUtil.sendApplication(_generateMeetingInfoPut(), _generateUserInfo(), (val){
                if(val == true){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context){
                      return ApplyProgress(int.parse(leaderId));
                    }),
                  );
                }
              });
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Map<String, dynamic> _generateMeetingInfoPut(){
    return{
      "id": meeting.id,
      "name": meetingName,
      "leader": {"id": int.parse(leaderId)},
      "room": {"id": int.parse(meetingRoomId)},
      "startTime": meetingDate + " " + meetingStartTime + ":00",
      "endTime": meetingDate + " " + meetingEndTime + ":00",
      "state": 0,
    };
  }

  Map<String, dynamic> _generateMeetingInfo(){
    return{
      "name": meetingName,
      "leader": {"id": int.parse(leaderId)},
      "room": {"id": int.parse(meetingRoomId)},
      "startTime": meetingDate + " " + meetingStartTime + ":00",
      "endTime": meetingDate + " " + meetingEndTime + ":00",
      "state": 0,
    };
  }

  List<Map<String, dynamic>> _generateUserInfo(){
    List<Map<String, dynamic>> userIds = new List();
    if(!selectedUsers.contains(leaderId)){
      selectedUsers.add(leaderId);
    }
    for(int i = 0; i < selectedUsers.length; i++){
      userIds.add({"id": int.parse(selectedUsers[i])});
    }
    return userIds;
  }
}