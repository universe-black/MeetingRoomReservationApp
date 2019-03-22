import 'package:flutter/material.dart';
import '../utils/net_util.dart';
import '../model/department.dart';
import '../model/department_user.dart';

class UserPicker extends StatefulWidget{
  List<String> preDoc;

  UserPicker(this.preDoc);

  @override
  State<StatefulWidget> createState() {
    return new UserPickerState(preDoc);
  }
}

class UserPickerState extends State<UserPicker>{
  List<String> preDoc;

  UserPickerState(this.preDoc);

  List<Departments> departmentList;
  List<Tab> tabList;
  List<UserListView> viewList;

  List<String> selectedUsers;

  @override
  void initState() {
    super.initState();
    selectedUsers = preDoc.length != 0 ? preDoc : new List();
    getDepartment();
  }
  
  void getDepartment(){
    NetUtil.get(
      "/department/all",
      (data){
        setState(() {
          departmentList = Department.fromJson(data).extras.departments;
          tabList = new List();
          viewList = new List();
          for(Departments e in departmentList){
            tabList.add(Tab(text: e.name));
            viewList.add(UserListView(e.id, onListChanged, selectedUsers));
          }
        });
      },
      null,
    );
  }

  void onListChanged(Users user, bool isSelected){
    setState(() {
      if(isSelected){
        selectedUsers.add(user.id.toString());
        print(user.realName + " selected!");
      }
      else{
        if(selectedUsers.contains(user.id.toString())) {
          selectedUsers.remove(user.id.toString());
          print(user.realName + " removed!");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(departmentList == null){
      return Scaffold(
        appBar: AppBar(
          title: Text("选择与会人员"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    else{
      return DefaultTabController(
        length: tabList.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text("选择与会人员"),
            bottom: TabBar(tabs: tabList),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.check, color: Colors.white,),
                onPressed: (){
                  Navigator.of(context).pop(selectedUsers);
                },
              ),
            ],
          ),
          body: TabBarView(children: viewList),
        ),
      );
    }
  }
}

class UserListView extends StatefulWidget{
  int departmentId;
  Function listChangedCallback;
  List<String> selectedUsers;
  
  UserListView(this.departmentId, this.listChangedCallback, this.selectedUsers);
  
  @override
  State<StatefulWidget> createState() {
    return new UserListViewState(departmentId, listChangedCallback, selectedUsers);
  }
}

class UserListViewState extends State<UserListView>{
  int departmentId;
  Function listChangedCallback;
  List<String> selectedUsers;
  
  UserListViewState(this.departmentId, this.listChangedCallback, this.selectedUsers);

  List<Users> userList;

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void getUsers(){
    NetUtil.get(
      "/department/users",
      (data){
        setState(() {
          userList = DepartmentUser.fromJson(data).extras.users;
        });
      },
      {"id": departmentId},
    );
  }

  @override
  Widget build(BuildContext context) {
    return userList == null ? Center(child: CircularProgressIndicator()) : ListView(
      padding: EdgeInsets.only(left: 30, right: 30),
      children: userList.map((Users user){
        return ListItem(user, listChangedCallback, selectedUsers.contains(user.id.toString()));
      }).toList(),
    );
  }
}

class ListItem extends StatefulWidget{
  Users user;
  Function listChangedCallback;
  bool isInPreDoc;

  ListItem(this.user, this.listChangedCallback, this.isInPreDoc);

  @override
  State<StatefulWidget> createState() {
    return new ListItemState(user, listChangedCallback, isInPreDoc);
  }
}

class ListItemState extends State<ListItem>{
  Users user;
  Function listChangedCallback;
  bool isInPreDoc;

  ListItemState(this.user, this.listChangedCallback, this.isInPreDoc);

  Icon icon;
  bool isChecked;

  @override
  void initState() {
    super.initState();
    if(!isInPreDoc){
      icon = Icon(Icons.check_box_outline_blank);
      isChecked = false;
    }
    else{
      icon = Icon(Icons.check_box);
      isChecked = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: ListTile(
            onTap: (){
              if(!isChecked){
                setState(() {
                  isChecked = true;
                  icon = Icon(Icons.check_box);
                  listChangedCallback(user, isChecked);
                });
              }
              else{
                setState(() {
                  isChecked = false;
                  icon = Icon(Icons.check_box_outline_blank);
                  listChangedCallback(user, isChecked);
                });
              }
            },
            leading: icon,
            title: Text(user.realName),
          ),
        ),
        Text(user.email),
      ],
    );
  }
}