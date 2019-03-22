// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_rooms_by_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableRoomsByTime _$AvailableRoomsByTimeFromJson(Map<String, dynamic> json) {
  return new AvailableRoomsByTime(
      json['code'] as int,
      json['extras'] == null
          ? null
          : new Extras.fromJson(json['extras'] as Map<String, dynamic>));
}

abstract class _$AvailableRoomsByTimeSerializerMixin {
  int get code;
  Extras get extras;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'code': code, 'extras': extras};
}

Extras _$ExtrasFromJson(Map<String, dynamic> json) {
  return new Extras((json['rooms'] as List)
      ?.map((e) => e == null
          ? null
          : new AvailableRooms.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

abstract class _$ExtrasSerializerMixin {
  List<AvailableRooms> get rooms;
  Map<String, dynamic> toJson() => <String, dynamic>{'rooms': rooms};
}

AvailableRooms _$AvailableRoomsFromJson(Map<String, dynamic> json) {
  return new AvailableRooms(
      json['id'] as int,
      json['name'] as String,
      json['location'] as String,
      json['capacity'] as int,
      json['available'] as bool,
      json['microphoneAvailable'] as bool,
      json['projectorAvailable'] as bool);
}

abstract class _$AvailableRoomsSerializerMixin {
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
