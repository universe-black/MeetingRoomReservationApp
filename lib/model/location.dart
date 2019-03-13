import '../model/meeting.dart';

class Building{
  final String building_number;
  final List<Map<String, dynamic>> rooms;

  const Building(this.building_number, this.rooms);

  Building.fromJson(Map<String, dynamic> json)
    : building_number = json['building_number'],
      rooms = json['rooms'];

  Map<String, dynamic> toJson() => {
    'building_number': building_number,
    'rooms': rooms,
  };
}

class Room{
  final String room_number;
  final String current_state;
  final List<Map<String, dynamic>> meetings;

  const Room(this.room_number, this.current_state, this.meetings);

  Room.fromJson(Map<String, dynamic> json)
    : room_number = json['room_number'],
      current_state = json['current_state'],
      meetings = json['meetings'];

  Map<String, dynamic> toJson() => {
    'room_number': room_number,
    'current_state': current_state,
    'meetings': meetings,
  };
}

Map<String, dynamic> room_json = {
  'room_number': '20-506',
  'current_state': '暂无安排',
  'meetings': meetings,
};

final List<Map<String, dynamic>> rooms = [
  room_json,
  room_json,
  room_json,
  room_json,
  room_json,
  room_json,
  room_json,
  room_json,
  room_json,
  room_json,
  room_json,
  room_json,
  room_json,
  room_json,
  room_json,
];

Map<String, dynamic> building_json = {
  'building_number': '20幢',
  'rooms': rooms,
};

final List<Map<String, dynamic>> buildings = [
  building_json,
  building_json,
  building_json,
  building_json,
  building_json,
  building_json,
  building_json,
  building_json,
  building_json,
  building_json,
  building_json,
  building_json,
  building_json,
  building_json,
  building_json,
  building_json,
];