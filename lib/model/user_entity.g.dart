// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) {
  return new UserEntity(
      json['code'] as int,
      json['extras'] == null
          ? null
          : new Extras.fromJson(json['extras'] as Map<String, dynamic>));
}

abstract class _$UserEntitySerializerMixin {
  int get code;
  Extras get extras;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'code': code, 'extras': extras};
}

Extras _$ExtrasFromJson(Map<String, dynamic> json) {
  return new Extras(json['user'] == null
      ? null
      : new User.fromJson(json['user'] as Map<String, dynamic>));
}

abstract class _$ExtrasSerializerMixin {
  User get user;
  Map<String, dynamic> toJson() => <String, dynamic>{'user': user};
}

User _$UserFromJson(Map<String, dynamic> json) {
  return new User(
      json['id'] as int,
      json['username'] as String,
      json['realName'] as String,
      json['phone'] as String,
      json['email'] as String,
      json['photoPath'] as String,
      json['department'] == null
          ? null
          : new Department.fromJson(
              json['department'] as Map<String, dynamic>));
}

abstract class _$UserSerializerMixin {
  int get id;
  String get username;
  String get realName;
  String get phone;
  String get email;
  String get photoPath;
  Department get department;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'username': username,
        'realName': realName,
        'phone': phone,
        'email': email,
        'photoPath': photoPath,
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
