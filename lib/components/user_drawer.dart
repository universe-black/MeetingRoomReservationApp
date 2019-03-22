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
            title: Text('系统设置'),
            leading: BadgeIconButton(
              itemCount: 0,
              icon: Icon(Icons.settings, size: 40),
            ),
          ),
          ListTile(
            title: Text('联系我们'),
            leading: BadgeIconButton(
              itemCount: 0,
              icon: Icon(Icons.phone_in_talk, size: 40),
            ),
          ),
          ListTile(
            title: Text('更换主题'),
            leading: BadgeIconButton(
              itemCount: 0,
              icon: Icon(Icons.local_florist, size: 40),
            ),
          ),
        ],
      ),
    );
  }
}