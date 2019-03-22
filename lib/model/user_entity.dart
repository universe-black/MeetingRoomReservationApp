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

  @JsonKey(name: 'password')
  String password;

  @JsonKey(name: 'phone')
  String phone;

  @JsonKey(name: 'email')
  String email;

  User(this.id,this.username,this.realName,this.password,this.phone,this.email,);

  factory User.fromJson(Map<String, dynamic> srcJson) => _$UserFromJson(srcJson);

}


