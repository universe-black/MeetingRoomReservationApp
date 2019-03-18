import 'package:flutter/material.dart';
import '../components/meeting_overview.dart';
import '../model/room_list.dart';
import '../utils/net_util.dart';

class RoomOverview extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return RoomOverviewState();
  }
}

class RoomOverviewState extends State<RoomOverview>{
  int total;
  int available;
  List<Content> content;

  @override
  void initState(){
    if(total != null && available != null){
      total = null;
      available = null;
    }
    getContent();
    super.initState();
  }

  int getAvailable(RoomList roomList){
    int count = 0;
    for(int i = 0; i < roomList.extras.rooms.numberOfElements; i++)
      if(roomList.extras.rooms.content[i].available == true)
        count++;

    return count;
  }

  void getContent(){
    Map<String, dynamic> params = {"size": 1000000};
    NetUitl.get(
      "/room/list",
          (data){
        RoomList roomList = RoomList.fromJson(data);
        setState(() {
          total = roomList.extras.rooms.numberOfElements;
          available = getAvailable(roomList);
          content = roomList.extras.rooms.content;
        });
      },
      params,
    );
  }

  Widget getTitleSection(){
    return Container(
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
          Text('共：$total'),
          Text('空闲会议室：$available'),
        ],
      ),
    );
  }

  Widget getTableHead(){
    return Container(
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
  }

  @override
  Widget build(BuildContext context){
    if(total == null && available == null){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    else{
      return Column(
        children: <Widget>[
          getTitleSection(),
          getTableHead(),
        Expanded(
          child: BuildingNav(content),
        ),
        ],
      );
    }
  }
}

class RoomListView extends StatefulWidget{
  List<Content> content;
  String building;

  RoomListView(this.content, this.building);

  @override
  State<StatefulWidget> createState() {
    return RoomListViewState(content, building);
  }
}

class RoomListViewState extends State<RoomListView>{
  List<Content> content;
  String building;

  RoomListViewState(this.content, this.building);

  List<Content> contents;

  @override
  void initState() {
    super.initState();
    contents = getRooms(content);
  }

  void getContent(){
    Map<String, dynamic> params = {"size": 1000000};
    NetUitl.get(
      "/room/list",
          (data){
        RoomList roomList = RoomList.fromJson(data);
        setState(() {
          getRooms(roomList.extras.rooms.content);
        });
      },
      params,
    );
  }

  List<Content> getRooms(List<Content> content){
    contents = new List();
    for(Content e in content){
      if(e.location == building){
        contents.add(e);
      }
    }
    return contents;
  }

  Future<Null> _onRefresh() async{
    await Future.delayed(Duration(seconds: 1), (){
      print('hello');
      setState(() {
        getContent();
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      child: ListView.separated(
        itemCount: contents.length,
        itemBuilder: (context, i){
          return Container(
            padding: EdgeInsets.only(left: 15, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  child: Text(contents[i].name),
                  color: Colors.green[400],
                  highlightColor: Colors.green[200],
                  splashColor: Colors.white,
                  textColor: Colors.white,
                  elevation: 5,
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MeetingOverview(contents[i].id, contents[i].name)),
                    );
                  },
                ),
                contents[i].available ? Text("暂无安排") : Text("已被占用"),
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
  List<Content> content;

  BuildingNav(this.content);

  @override
  State<StatefulWidget> createState() {
    return BuildingNavState(content);
  }
}

class BuildingNavState extends State<BuildingNav>{
  List<Content> content;

  BuildingNavState(this.content);

  List<Tab> tabList;
  List<RoomListView> viewList;

  initData(){
    tabList = new List();
    viewList = new List();
    Set<String> set = new Set();
    for(Content e in content){
      set.add(e.location);
    }
    List<String> buildingList = set.toList();
    buildingList.sort((a, b) => a.compareTo(b));
    for(int i = 0; i < buildingList.length; i++){
      tabList.add(Tab(text: buildingList[i] + "幢"));
      viewList.add(RoomListView(content, buildingList[i]));
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

