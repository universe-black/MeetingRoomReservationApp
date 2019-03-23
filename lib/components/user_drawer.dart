import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import '../components/user_config.dart';
import '../model/user_entity.dart';

class UserDrawer extends StatefulWidget{
  User user;

  UserDrawer(this.user);

  @override
  State<StatefulWidget> createState() {
    return new UserDrawerState(user);
  }
}

class UserDrawerState extends State<UserDrawer>{
  User user;

  UserDrawerState(this.user);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(user.realName, style: TextStyle(fontWeight: FontWeight.bold)),
            accountEmail: Text(user.email),
            currentAccountPicture: GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserConfig()),
                );
              },
              child: CircleAvatar(
                backgroundImage: AssetImage('images/user.png'),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            title: Text('我的预约'),
            leading: BadgeIconButton(
              itemCount: 0,
              icon: Icon(Icons.account_circle, size: 40),
            ),
          ),
          ListTile(
            title: Text('历史通知'),
            leading: BadgeIconButton(
              itemCount: 9,
              icon: Icon(Icons.add_alert, size: 40),
            ),
          ),
          ListTile(
            onTap: (){
              showDialog(context: context, builder: (ctx) => AlertDialog(
                title: Text("假装有选项"),
                content: Text("目前还没有可以设置的选项呢\n\n(不过点击头像有用户选项哦)\n︿(￣︶￣)︿"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("行吧"),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));
            },
            title: Text('系统设置'),
            leading: BadgeIconButton(
              itemCount: 0,
              icon: Icon(Icons.settings, size: 40),
            ),
          ),
          ListTile(
            onTap: (){
              showDialog(context: context, builder: (ctx) => AlertDialog(
                title: Text("主题？什么主题？"),
                content: Text("开发者太懒了，\n更多主题设计中...\nΣ( ° △ °|||)︴"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("哼"),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));
            },
            title: Text('更换主题'),
            leading: BadgeIconButton(
              itemCount: 0,
              icon: Icon(Icons.local_florist, size: 40),
            ),
          ),
          ListTile(
            onTap: (){
              showDialog(context: context, builder: (ctx) => AlertDialog(
                title: Text("开发者信息"),
                content: Text("开发团队：“复读机真香”团队\n\n"
                    "App开发者联系方式:\n"
                    "universe_black@qq.com\n\n"
                    "o(*￣▽￣*)ブ"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("我知道啦"),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));
            },
            title: Text('联系我们'),
            leading: BadgeIconButton(
              itemCount: 0,
              icon: Icon(Icons.phone_in_talk, size: 40),
            ),
          ),
        ],
      ),
    );
  }
}