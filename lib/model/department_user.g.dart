// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartmentUser _$DepartmentUserFromJson(Map<String, dynamic> json) {
  return new DepartmentUser(
      json['code'] as int,
      json['extras'] == null
          ? null
          : new Extras.fromJson(json['extras'] as Map<String, dynamic>));
}

abstract class _$DepartmentUserSerializerMixin {
  int get code;
  Extras get extras;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'code': code, 'extras': extras};
}

Extras _$ExtrasFromJson(Map<String, dynamic> json) {
  return new Extras((json['users'] as List)
      ?.map((e) =>
          e == null ? null : new Users.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

abstract class _$ExtrasSerializerMixin {
  List<Users> get users;
  Map<String, dynamic> toJson() => <String, dynamic>{'users': users};
}

Users _$UsersFromJson(Map<String, dynamic> json) {
  return new Users(
      json['id'] as int,
      json['username'] as String,
      json['realName'] as String,
      json['password'] as String,
      json['phone'] as String,
      json['email'] as String);
}

abstract class _$UsersSerializerMixin {
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
