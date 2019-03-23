import 'package:flutter/material.dart';
import '../components/meeting_overview.dart';
import '../model/room_list.dart';
import '../model/available_rooms_by_time.dart';
import '../utils/net_util.dart';

class RoomOverview extends StatefulWidget{
  int typeCode;
  String startTime;
  String endTime;
  RoomOverview(this.typeCode, {this.startTime, this.endTime});

  @override
  State<StatefulWidget> createState() {
    if(typeCode == 0){
      return RoomOverviewState(typeCode);
    }
    else{
      return RoomOverviewState(typeCode, startTime: startTime, endTime: endTime);
    }
  }
}

class RoomOverviewState extends State<RoomOverview>{
  int typeCode;
  String startTime;
  String endTime;

  RoomOverviewState(this.typeCode, {this.startTime, this.endTime});

  int total;
  int available;
  List<Content> content;
  List<AvailableRooms> availableRoomsByTime;

  @override
  void initState(){
    super.initState();
    if(total != null && available != null){
      total = null;
      available = null;
    }
    getContent();
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
    NetUtil.get(
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
    if(typeCode != 0){
      getAvailableRoomsByTime();
    }
  }
  void getAvailableRoomsByTime(){
    availableRoomsByTime = new List();
    NetUtil.get(
      "/room/available",
      (data){
        setState(() {
          availableRoomsByTime = AvailableRoomsByTime.fromJson(data).extras.rooms;
        });
      },
      {"startTime": startTime, "endTime": endTime},
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
          Text('可用会议室：$available'),
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
          Text("容量"),
          Text("麦克风"),
          Text("投影仪"),
          typeCode == 0 ? Text("当前状态") : Text("是否冲突"),
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
      if(typeCode == 0){
        return Column(
          children: <Widget>[
            getTitleSection(),
            getTableHead(),
            Expanded(child: BuildingNav(content, typeCode),),
          ],
        );
      }
      else if(availableRoomsByTime.length == 0){
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      else{
        return Column(
          children: <Widget>[
            getTitleSection(),
            getTableHead(),
            Expanded(child: BuildingNav(content, typeCode, availableRoomsByTime: availableRoomsByTime,),),
          ],
        );
      }
    }
  }
}

class RoomListView extends StatefulWidget{
  List<Content> content;
  String building;
  int typeCode;
  List<AvailableRooms> availableRoomsByTime;

  RoomListView(this.content, this.building, this.typeCode, {this.availableRoomsByTime});

  @override
  State<StatefulWidget> createState() {
    return typeCode == 0 ? RoomListViewState(content, building, typeCode) : RoomListViewState(content, building, typeCode, availableRoomsByTime: availableRoomsByTime);
  }
}

class RoomListViewState extends State<RoomListView>{
  List<Content> content;
  String building;
  int typeCode;
  List<AvailableRooms> availableRoomsByTime;

  RoomListViewState(this.content, this.building, this.typeCode, {this.availableRoomsByTime});

  List<Content> contents;
  
  List<int> availableIds;

  @override
  void initState() {
    super.initState();
    contents = getRooms(content);
    availableIds = new List();
    if(availableRoomsByTime != null){
      for(AvailableRooms e in availableRoomsByTime){
        availableIds.add(e.id);
      }
    }
  }

  void getContent(){
    Map<String, dynamic> params = {"size": 1000000};
    NetUtil.get(
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
      setState(() {
        getContent();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(typeCode == 0){
      return RefreshIndicator(
        child: ListView.separated(
          itemCount: contents.length,
          itemBuilder: (context, i){
            return Container(
              padding: EdgeInsets.only(right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    child: Text(contents[i].name),
                    color: Colors.blue[400],
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
                  Text(contents[i].capacity.toString()),
                  contents[i].microphoneAvailable ? Icon(Icons.check, size: 35) : Icon(Icons.close, size: 35),
                  contents[i].projectorAvailable ? Icon(Icons.check, size: 35) : Icon(Icons.close, size: 35),
                  contents[i].available ? Text("可以使用", style: TextStyle(color: Theme.of(context).primaryColor),) : Text("不可使用"),
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
    else{
      return RefreshIndicator(
        child: ListView.separated(
          itemCount: contents.length,
          itemBuilder: (context, i){
            return Container(
              padding: EdgeInsets.only(right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    child: Text(contents[i].name),
                    color: Colors.blue[400],
                    highlightColor: Colors.green[200],
                    splashColor: Colors.white,
                    textColor: Colors.white,
                    elevation: 5,
                    onPressed: (){
                      Navigator.of(context).pop([contents[i].id.toString(), contents[i].name, !availableIds.contains(contents[i].id)]);
                    },
                  ),
                  Text(contents[i].capacity.toString()),
                  contents[i].microphoneAvailable ? Icon(Icons.check, size: 35) : Icon(Icons.close, size: 35),
                  contents[i].projectorAvailable ? Icon(Icons.check, size: 35) : Icon(Icons.close, size: 35),
                  availableIds.contains(contents[i].id) ? Text("暂无冲突", style: TextStyle(color: Theme.of(context).primaryColor),) : Text("时间冲突"),
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
}

class BuildingNav extends StatefulWidget{
  List<Content> content;
  int typeCode;
  List<AvailableRooms> availableRoomsByTime;

  BuildingNav(this.content, this.typeCode, {this.availableRoomsByTime});

  @override
  State<StatefulWidget> createState() {
    return typeCode == 0 ? BuildingNavState(content, typeCode) : BuildingNavState(content, typeCode, availableRoomsByTime: availableRoomsByTime);
  }
}

class BuildingNavState extends State<BuildingNav>{
  List<Content> content;
  int typeCode;
  List<AvailableRooms> availableRoomsByTime;

  BuildingNavState(this.content, this.typeCode, {this.availableRoomsByTime});

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
      if(typeCode == 0)
        viewList.add(RoomListView(content, buildingList[i], typeCode));
      else
        viewList.add(RoomListView(content, buildingList[i], typeCode, availableRoomsByTime: availableRoomsByTime));
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

