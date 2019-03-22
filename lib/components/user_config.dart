import 'package:flutter/material.dart';
import '../views/login.dart';
import '../utils/net_util.dart';
import '../components/modify_pwd.dart';

class UserConfig extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("用户选项"),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.asset("images/user_bg.png", fit: BoxFit.cover,),
              Positioned(
                top: 50,
                bottom: 50,
                left: 130,
                right: 130,
                child: SizedBox(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/user.png'),
                  ),
                ),
              ),
            ],
          ),
          _buildPwdChanger(context),
          _buildLogout(context),
        ],
      ),
    );
  }

  Widget _buildPwdChanger(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context){
            return ModifyPwd();
          })
        );
      },
      child: Card(
        color: Colors.green,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("修改密码", style: TextStyle(fontSize: 18, color: Colors.white),),
              Icon(Icons.arrow_forward_ios, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogout(BuildContext context){
    return GestureDetector(
      onTap: (){
        NetUtil.logout((bool val){
          if(val == true){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){return Login();}), (route) => route == null);
          }
          else{
            showDialog(context: context, builder: (ctx) => AlertDialog(
              title: Text("注销失败"),
              content: Text("遇到了奇怪的错误emmmm"),
            ));
          }
        });
      },
      child: Card(
        color: Colors.red,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Text("注销并退出", style: TextStyle(fontSize: 18, color: Colors.white),),
          ),
        ),
      ),
    );
  }
}