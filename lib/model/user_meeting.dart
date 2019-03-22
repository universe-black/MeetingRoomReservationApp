import 'package:json_annotation/json_annotation.dart';

part 'user_meeting.g.dart';


@JsonSerializable()
class UserMeeting extends Object with _$UserMeetingSerializerMixin{

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'extras')
  Extras extras;

  UserMeeting(this.code,this.extras,);

  factory UserMeeting.fromJson(Map<String, dynamic> srcJson) => _$UserMeetingFromJson(srcJson);

}


@JsonSerializable()
class Extras extends Object with _$ExtrasSerializerMixin{

  @JsonKey(name: 'meetings')
  List<Meetings> meetings;

  Extras(this.meetings,);

  factory Extras.fromJson(Map<String, dynamic> srcJson) => _$ExtrasFromJson(srcJson);

}


@JsonSerializable()
class Meetings extends Object with _$MeetingsSerializerMixin{

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

  Meetings(this.id,this.name,this.leader,this.room,this.startTime,this.endTime,this.state,);

  factory Meetings.fromJson(Map<String, dynamic> srcJson) => _$MeetingsFromJson(srcJson);

}


@JsonSerializable()
class Leader extends Object with _$LeaderSerializerMixin{

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'username')
  String username;

  @JsonKey(name: 'realName')
  String realName;

  @JsonKey(name: 'password')
  String password;

  @JsonKey(name: 'phone')
  String phone;

  @JsonKey(name: 'email')
  String email;

  Leader(this.id,this.username,this.realName,this.password,this.phone,this.email,);

  factory Leader.fromJson(Map<String, dynamic> srcJson) => _$LeaderFromJson(srcJson);

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


