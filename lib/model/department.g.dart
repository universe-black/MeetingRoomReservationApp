// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Department _$DepartmentFromJson(Map<String, dynamic> json) {
  return new Department(
      json['code'] as int,
      json['extras'] == null
          ? null
          : new Extras.fromJson(json['extras'] as Map<String, dynamic>));
}

abstract class _$DepartmentSerializerMixin {
  int get code;
  Extras get extras;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'code': code, 'extras': extras};
}

Extras _$ExtrasFromJson(Map<String, dynamic> json) {
  return new Extras((json['departments'] as List)
      ?.map((e) => e == null
          ? null
          : new Departments.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

abstract class _$ExtrasSerializerMixin {
  List<Departments> get departments;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'departments': departments};
}

Departments _$DepartmentsFromJson(Map<String, dynamic> json) {
  return new Departments(json['id'] as int, json['name'] as String);
}

abstract class _$DepartmentsSerializerMixin {
  int get id;
  String get name;
  Map<String, dynamic> toJson() => <String, dynamic>{'id': id, 'name': name};
}
