import 'package:flutter/material.dart';
import '../components/meeting_overview.dart';
import '../model/location.dart';

class RoomOverview extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return RoomOverviewState();
  }
}

class RoomOverviewState extends State<RoomOverview>{

  Widget titleSection = Container(
    decoration: BoxDecoration(
      color: Colors.grey[350],
    ),
    padding: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.home),
            Text('会议室概览'),
          ],
        ),
        Text('共：30'),
        Text('空闲会议室：20'),
      ],
    ),
  );

  Widget tableHead = Container(
    decoration: BoxDecoration(
      color: Colors.grey[200],
    ),
    padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text('会议室编号'),
        Text('当前状态'),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        titleSection,
        tableHead,
        Expanded(
          child: BuildingNav(),
        ),
      ],
    );
  }
}

class RoomListView extends StatefulWidget{
  final int index;

  RoomListView(this.index);

  @override
  State<StatefulWidget> createState() {
    return RoomListViewState(index);
  }
}

class RoomListViewState extends State<RoomListView>{
  int index;

  RoomListViewState(this.index);

  Future<Null> _onRefresh() async{
    await Future.delayed(Duration(seconds: 1), (){
      print('hello');
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> roomList = Building.fromJson(buildings[index]).rooms;
    return RefreshIndicator(
      child: ListView.separated(
        itemCount: roomList.length,
        itemBuilder: (context, i){
          return Container(
            padding: EdgeInsets.only(left: 15, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  child: Text(Room.fromJson(roomList[i]).room_number),
                  color: Colors.green[400],
                  highlightColor: Colors.green[200],
                  splashColor: Colors.white,
                  textColor: Colors.white,
                  elevation: 5,
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MeetingOverview(Room.fromJson(roomList[i]))),
                    );
                  },
                ),
                Text(Room.fromJson(roomList[i]).current_state)
              ],
            ),
          );
        },
        separatorBuilder: (context, i){
          return Divider(height: 1,);
        },
      ),
      onRefresh: _onRefresh,
    );
  }
}

class BuildingNav extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return BuildingNavState();
  }
}

class BuildingNavState extends State<BuildingNav>{
  List<Tab> tabList;
  List<RoomListView> viewList;

  initData(){
    tabList = new List();
    viewList = new List();
    for(int i = 0; i < buildings.length; i++){
      tabList.add(Tab(text: Building.fromJson(buildings[i]).building_number));
      viewList.add(RoomListView(i));
    }
  }

  @override
  Widget build(BuildContext context) {
    initData();

    return DefaultTabController(
      length: tabList.length,
      child: Scaffold(
        bottomNavigationBar: Material(
          color: Colors.grey[200],
          child: TabBar(
            labelStyle: TextStyle(fontSize: 15),
            isScrollable: true,
            labelColor: Theme.of(context).primaryColor,
            tabs: tabList,
          ),
        ),
        body: TabBarView(
          children: viewList,
        ),
      ),
    );
  }

}

