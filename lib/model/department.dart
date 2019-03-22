import 'package:json_annotation/json_annotation.dart';

part 'department.g.dart';


@JsonSerializable()
class Department extends Object with _$DepartmentSerializerMixin{

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'extras')
  Extras extras;

  Department(this.code,this.extras,);

  factory Department.fromJson(Map<String, dynamic> srcJson) => _$DepartmentFromJson(srcJson);

}


@JsonSerializable()
class Extras extends Object with _$ExtrasSerializerMixin{

  @JsonKey(name: 'departments')
  List<Departments> departments;

  Extras(this.departments,);

  factory Extras.fromJson(Map<String, dynamic> srcJson) => _$ExtrasFromJson(srcJson);

}


@JsonSerializable()
class Departments extends Object with _$DepartmentsSerializerMixin{

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  Departments(this.id,this.name,);

  factory Departments.fromJson(Map<String, dynamic> srcJson) => _$DepartmentsFromJson(srcJson);

}


