// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remind.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Remind _$RemindFromJson(Map<String, dynamic> json) {
  return new Remind(
      json['code'] as int,
      json['extras'] == null
          ? null
          : new Extras.fromJson(json['extras'] as Map<String, dynamic>));
}

abstract class _$RemindSerializerMixin {
  int get code;
  Extras get extras;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'code': code, 'extras': extras};
}

Extras _$ExtrasFromJson(Map<String, dynamic> json) {
  return new Extras((json['reminds'] as List)
      ?.map((e) =>
          e == null ? null : new Reminds.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

abstract class _$ExtrasSerializerMixin {
  List<Reminds> get reminds;
  Map<String, dynamic> toJson() => <String, dynamic>{'reminds': reminds};
}

Reminds _$RemindsFromJson(Map<String, dynamic> json) {
  return new Reminds(
      json['id'] as int,
      json['content'] as String,
      json['time'] as String,
      json['meeting'] == null
          ? null
          : new Meeting.fromJson(json['meeting'] as Map<String, dynamic>));
}

abstract class _$RemindsSerializerMixin {
  int get id;
  String get content;
  String get time;
  Meeting get meeting;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'content': content,
        'time': time,
        'meeting': meeting
      };
}

Meeting _$MeetingFromJson(Map<String, dynamic> json) {
  return new Meeting(
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

abstract class _$MeetingSerializerMixin {
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
      json['phone'] as String,
      json['email'] as String,
      json['department'] == null
          ? null
          : new Department.fromJson(
              json['department'] as Map<String, dynamic>));
}

abstract class _$LeaderSerializerMixin {
  int get id;
  String get username;
  String get realName;
  String get phone;
  String get email;
  Department get department;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'username': username,
        'realName': realName,
        'phone': phone,
        'email': email,
        'department': department
      };
}

Department _$DepartmentFromJson(Map<String, dynamic> json) {
  return new Department(json['id'] as int, json['name'] as String);
}

abstract class _$DepartmentSerializerMixin {
  int get id;
  String get name;
  Map<String, dynamic> toJson() => <String, dynamic>{'id': id, 'name': name};
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
