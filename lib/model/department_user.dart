import 'package:json_annotation/json_annotation.dart';

part 'department_user.g.dart';


@JsonSerializable()
class DepartmentUser extends Object with _$DepartmentUserSerializerMixin{

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'extras')
  Extras extras;

  DepartmentUser(this.code,this.extras,);

  factory DepartmentUser.fromJson(Map<String, dynamic> srcJson) => _$DepartmentUserFromJson(srcJson);

}


@JsonSerializable()
class Extras extends Object with _$ExtrasSerializerMixin{

  @JsonKey(name: 'users')
  List<Users> users;

  Extras(this.users,);

  factory Extras.fromJson(Map<String, dynamic> srcJson) => _$ExtrasFromJson(srcJson);

}


@JsonSerializable()
class Users extends Object with _$UsersSerializerMixin{

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

  Users(this.id,this.username,this.realName,this.password,this.phone,this.email,);

  factory Users.fromJson(Map<String, dynamic> srcJson) => _$UsersFromJson(srcJson);

}


