import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';


@JsonSerializable()
class UserEntity extends Object with _$UserEntitySerializerMixin{

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'extras')
  Extras extras;

  UserEntity(this.code,this.extras,);

  factory UserEntity.fromJson(Map<String, dynamic> srcJson) => _$UserEntityFromJson(srcJson);

}


@JsonSerializable()
class Extras extends Object with _$ExtrasSerializerMixin{

  @JsonKey(name: 'user')
  User user;

  Extras(this.user,);

  factory Extras.fromJson(Map<String, dynamic> srcJson) => _$ExtrasFromJson(srcJson);

}


@JsonSerializable()
class User extends Object with _$UserSerializerMixin{

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

  @JsonKey(name: 'photoPath')
  String photoPath;

  @JsonKey(name: 'department')
  Department department;

  User(this.id,this.username,this.realName,this.phone,this.email,this.photoPath,this.department,);

  factory User.fromJson(Map<String, dynamic> srcJson) => _$UserFromJson(srcJson);

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


