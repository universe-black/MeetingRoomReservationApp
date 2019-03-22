import 'package:json_annotation/json_annotation.dart';

part 'available_rooms_by_time.g.dart';


@JsonSerializable()
class AvailableRoomsByTime extends Object with _$AvailableRoomsByTimeSerializerMixin{

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'extras')
  Extras extras;

  AvailableRoomsByTime(this.code,this.extras,);

  factory AvailableRoomsByTime.fromJson(Map<String, dynamic> srcJson) => _$AvailableRoomsByTimeFromJson(srcJson);

}


@JsonSerializable()
class Extras extends Object with _$ExtrasSerializerMixin{

  @JsonKey(name: 'rooms')
  List<AvailableRooms> rooms;

  Extras(this.rooms,);

  factory Extras.fromJson(Map<String, dynamic> srcJson) => _$ExtrasFromJson(srcJson);

}


@JsonSerializable()
class AvailableRooms extends Object with _$AvailableRoomsSerializerMixin{

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'location')
  String location;

  @JsonKey(name: 'capacity')
  int capacity;

  @JsonKey(name: 'available')
  bool available;

  @JsonKey(name: 'microphoneAvailable')
  bool microphoneAvailable;

  @JsonKey(name: 'projectorAvailable')
  bool projectorAvailable;

  AvailableRooms(this.id,this.name,this.location,this.capacity,this.available,this.microphoneAvailable,this.projectorAvailable,);

  factory AvailableRooms.fromJson(Map<String, dynamic> srcJson) => _$AvailableRoomsFromJson(srcJson);

}


