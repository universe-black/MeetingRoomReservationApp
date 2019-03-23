import 'package:json_annotation/json_annotation.dart';

part 'remind.g.dart';


@JsonSerializable()
class Remind extends Object with _$RemindSerializerMixin{

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'extras')
  Extras extras;

  Remind(this.code,this.extras,);

  factory Remind.fromJson(Map<String, dynamic> srcJson) => _$RemindFromJson(srcJson);

}


@JsonSerializable()
class Extras extends Object with _$ExtrasSerializerMixin{

  @JsonKey(name: 'reminds')
  List<Reminds> reminds;

  Extras(this.reminds,);

  factory Extras.fromJson(Map<String, dynamic> srcJson) => _$ExtrasFromJson(srcJson);

}


@JsonSerializable()
class Reminds extends Object with _$RemindsSerializerMixin{

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'time')
  String time;

  @JsonKey(name: 'meeting')
  Meeting meeting;

  Reminds(this.id,this.content,this.time,this.meeting,);

  factory Reminds.fromJson(Map<String, dynamic> srcJson) => _$RemindsFromJson(srcJson);

}


@JsonSerializable()
class Meeting extends Object with _$MeetingSerializerMixin{

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'leader')
  Leader leader;

  @JsonKey(name: 'room')
  Room room;

  @JsonKey(name: 'startTime')
  String startTime;

  @JsonKey(name: 'endTime')
  String endTime;

  @JsonKey(name: 'state')
  int state;

  Meeting(this.id,this.name,this.leader,this.room,this.startTime,this.endTime,this.state,);

  factory Meeting.fromJson(Map<String, dynamic> srcJson) => _$MeetingFromJson(srcJson);

}


@JsonSerializable()
class Leader extends Object with _$LeaderSerializerMixin{

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'username')
  String username;

  @JsonKey(name: 'realName')
  String realName;

  @JsonKey(name: 'phone')
  String phone;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'department')
  Department department;

  Leader(this.id,this.username,this.realName,this.phone,this.email,this.department,);

  factory Leader.fromJson(Map<String, dynamic> srcJson) => _$LeaderFromJson(srcJson);

}


@JsonSerializable()
class Department extends Object with _$DepartmentSerializerMixin{

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  Department(this.id,this.name,);

  factory Department.fromJson(Map<String, dynamic> srcJson) => _$DepartmentFromJson(srcJson);

}


@JsonSerializable()
class Room extends Object with _$RoomSerializerMixin{

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'location')
  String location;

  @JsonKey(name: 'capacity')
  int capacity;

  @JsonKey(name: 'available')
  bool available;

  @JsonKey(name: 'microphoneAvailable')
  bool microphoneAvailable;

  @JsonKey(name: 'projectorAvailable')
  bool projectorAvailable;

  Room(this.id,this.name,this.location,this.capacity,this.available,this.microphoneAvailable,this.projectorAvailable,);

  factory Room.fromJson(Map<String, dynamic> srcJson) => _$RoomFromJson(srcJson);

}


