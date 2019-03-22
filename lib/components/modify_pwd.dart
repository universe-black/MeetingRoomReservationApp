import 'package:flutter/material.dart';
import '../utils/net_util.dart';
import '../views/login.dart';

class ModifyPwd extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new ModifyPwdState();
  }
}

class ModifyPwdState extends State<ModifyPwd>{
  String oldPassword;
  String newPassword1;
  String newPassword2;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("修改密码"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  _buildOldPwdInput(),
                  _buildNewPwd1Input(),
                  _buildNewPwd2Input(),
                  SizedBox(height: 50,),
                  _buildSubmitButton(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOldPwdInput(){
    return ListTile(
      contentPadding: EdgeInsets.only(left: 50, right: 50),
      title: TextFormField(
        decoration: InputDecoration(labelText: "原密码", icon: Icon(Icons.lock, size: 50,)),
        obscureText: true,
        onSaved: (val) => oldPassword = val,
        validator: (val){
          if(val.isEmpty){
            return "请输入原密码";
          }
        },
      ),
    );
  }

  Widget _buildNewPwd1Input(){
    return ListTile(
      contentPadding: EdgeInsets.only(left: 50, right: 50),
      title: TextFormField(
        decoration: InputDecoration(labelText: "新密码", icon: Icon(Icons.lock_outline, size: 50,)),
        obscureText: true,
        onSaved: (val) => newPassword1 = val,
        validator: (val){
          RegExp exp1 = new RegExp(r"(\w+)");
          RegExp exp2 = new RegExp(r"(\d+)");
          if(val.isEmpty){
            return "请输入新密码";
          }
          if(val.length < 6){
            return "密码过短，至少需要6位，但不超过16位";
          }
          else if(val.length > 16){
            return "密码过长，至少需要6位，但不超过16位";
          }
          else if(!exp1.hasMatch(val) || !exp2.hasMatch(val)){
            return "密码必须含有字母和数字";
          }
          else{
            setState(() {
              newPassword1 = val;
            });
          }
        },
      ),
    );
  }

  Widget _buildNewPwd2Input(){
    return ListTile(
      contentPadding: EdgeInsets.only(left: 50, right: 50),
      title: TextFormField(
        decoration: InputDecoration(labelText: "确认新密码", icon: Icon(Icons.lock_outline, size: 50,)),
        obscureText: true,
        onSaved: (val) => newPassword2 = val,
        validator: (val){
          if(val != newPassword1){
            return "两次输入新密码不一致";
          }
        },
      ),
    );
  }

  Widget _buildSubmitButton(){
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50),
      child: RaisedButton(
        shape: StadiumBorder(),
        color: Theme.of(context).primaryColor,
        child: Text("修 改", style: TextStyle(fontSize: 18, color: Colors.white),),
        onPressed: (){
          final form = _formKey.currentState;
          if(form.validate()){
            form.save();
            NetUtil.modifyPwd(oldPassword, newPassword1, (bool val){
              if(val == true){
                showDialog(context: context, builder: (ctx) => AlertDialog(
                  title: Text("修改成功"),
                  content: Text("请重新登录！"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("确定"),
                      onPressed: (){
                        NetUtil.reset();
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){return Login();}), (route) => route == null);
                      },
                    ),
                  ],
                ));
              }
              else{
                showDialog(context: context, builder: (ctx) => AlertDialog(
                  title: Text("原密码错误"),
                  content: Text("请重新输入。"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("确定"),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ));
              }
            });
          }
        },
      ),
    );
  }
}