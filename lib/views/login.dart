import 'package:flutter/material.dart';
import '../utils/net_util.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new LoginState();
  }
}

class LoginState extends State<Login>{
  String username;
  String password;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("用户登录"),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 100,
            width: 100,
            child: Image.asset('images/user.png'),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  _buildUsernameInput(),
                  _buildPasswordInput(),
                  SizedBox(height: 50,),
                  _buildSubmitButton(),
                  SizedBox(
                    height: 50,
                    child: Center(
                      child: Text("登录遇到问题请与管理员联系", style: TextStyle(color: Colors.green[300], fontSize: 12)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildUsernameInput(){
    return ListTile(
      contentPadding: EdgeInsets.only(left: 50, right: 50),
      title: TextFormField(
        decoration: InputDecoration(labelText: "用户名", icon: Icon(Icons.account_circle, size: 50,)),
        onSaved: (val) => username = val,
        validator: (val){
          if(val.isEmpty){
            return "请输入用户名";
          }
        },
      ),
    );
  }

  Widget _buildPasswordInput(){
    return ListTile(
      contentPadding: EdgeInsets.only(left: 50, right: 50),
      title: TextFormField(
        decoration: InputDecoration(labelText: "密码", icon: Icon(Icons.lock, size: 50,)),
        obscureText: true,
        onSaved: (val) => password = val,
        validator: (val){
          if(val.isEmpty){
            return "请输入密码";
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
        child: Text("登 录", style: TextStyle(fontSize: 18, color: Colors.white),),
        onPressed: (){
          final form = _formKey.currentState;
          if(form.validate()){
            form.save();
            NetUtil.login(username, password, (bool val){
              if(val == true){
                Navigator.of(context).pushReplacementNamed('/home');
              }
              else{
                showDialog(context: context, builder: (ctx) => AlertDialog(
                  title: Text("用户名或密码错误"),
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