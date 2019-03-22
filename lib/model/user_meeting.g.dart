// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_meeting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMeeting _$UserMeetingFromJson(Map<String, dynamic> json) {
  return new UserMeeting(
      json['code'] as int,
      json['extras'] == null
          ? null
          : new Extras.fromJson(json['extras'] as Map<String, dynamic>));
}

abstract class _$UserMeetingSerializerMixin {
  int get code;
  Extras get extras;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'code': code, 'extras': extras};
}

Extras _$ExtrasFromJson(Map<String, dynamic> json) {
  return new Extras((json['meetings'] as List)
      ?.map((e) =>
          e == null ? null : new Meetings.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

abstract class _$ExtrasSerializerMixin {
  List<Meetings> get meetings;
  Map<String, dynamic> toJson() => <String, dynamic>{'meetings': meetings};
}

Meetings _$MeetingsFromJson(Map<String, dynamic> json) {
  return new Meetings(
      json['id'] as int,
      json['name'] as String,
      json['leader'] == null
          ? null
          : new Leader.fromJson(json['leader'] as Map<String, dynamic>),
      json['room'] == null
          ? null
          : new Room.fromJson(json['room'] as Map<String, dynamic>),
      json['startTime'] as String,
      json['endTime'] as String,
      json['state'] as int);
}

abstract class _$MeetingsSerializerMixin {
  int get id;
  String get name;
  Leader get leader;
  Room get room;
  String get startTime;
  String get endTime;
  int get state;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'leader': leader,
        'room': room,
        'startTime': startTime,
        'endTime': endTime,
        'state': state
      };
}

Leader _$LeaderFromJson(Map<String, dynamic> json) {
  return new Leader(
      json['id'] as int,
      json['username'] as String,
      json['realName'] as String,
      json['password'] as String,
      json['phone'] as String,
      json['email'] as String);
}

abstract class _$LeaderSerializerMixin {
  int get id;
  String get username;
  String get realName;
  String get password;
  String get phone;
  String get email;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'username': username,
        'realName': realName,
        'password': password,
        'phone': phone,
        'email': email
      };
}

Room _$RoomFromJson(Map<String, dynamic> json) {
  return new Room(
      json['id'] as int,
      json['name'] as String,
      json['location'] as String,
      json['capacity'] as int,
      json['available'] as bool,
      json['microphoneAvailable'] as bool,
      json['projectorAvailable'] as bool);
}

abstract class _$RoomSerializerMixin {
  int get id;
  String get name;
  String get location;
  int get capacity;
  bool get available;
  bool get microphoneAvailable;
  bool get projectorAvailable;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'location': location,
        'capacity': capacity,
        'available': available,
        'microphoneAvailable': microphoneAvailable,
        'projectorAvailable': projectorAvailable
      };
}
