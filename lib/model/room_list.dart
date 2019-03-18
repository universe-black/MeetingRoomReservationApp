import 'package:json_annotation/json_annotation.dart';

part 'room_list.g.dart';


@JsonSerializable()
class RoomList extends Object with _$RoomListSerializerMixin{

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'extras')
  Extras extras;

  RoomList(this.code,this.extras,);

  factory RoomList.fromJson(Map<String, dynamic> srcJson) => _$RoomListFromJson(srcJson);

}


@JsonSerializable()
class Extras extends Object with _$ExtrasSerializerMixin{

  @JsonKey(name: 'rooms')
  Rooms rooms;

  Extras(this.rooms,);

  factory Extras.fromJson(Map<String, dynamic> srcJson) => _$ExtrasFromJson(srcJson);

}


@JsonSerializable()
class Rooms extends Object with _$RoomsSerializerMixin{

  @JsonKey(name: 'content')
  List<Content> content;

  @JsonKey(name: 'pageable')
  Pageable pageable;

  @JsonKey(name: 'last')
  bool last;

  @JsonKey(name: 'totalPages')
  int totalPages;

  @JsonKey(name: 'totalElements')
  int totalElements;

  @JsonKey(name: 'number')
  int number;

  @JsonKey(name: 'sort')
  Sort sort;

  @JsonKey(name: 'size')
  int size;

  @JsonKey(name: 'first')
  bool first;

  @JsonKey(name: 'numberOfElements')
  int numberOfElements;

  @JsonKey(name: 'empty')
  bool empty;

  Rooms(this.content,this.pageable,this.last,this.totalPages,this.totalElements,this.number,this.sort,this.size,this.first,this.numberOfElements,this.empty,);

  factory Rooms.fromJson(Map<String, dynamic> srcJson) => _$RoomsFromJson(srcJson);

}


@JsonSerializable()
class Content extends Object with _$ContentSerializerMixin{

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

  Content(this.id,this.name,this.location,this.capacity,this.available,this.microphoneAvailable,this.projectorAvailable,);

  factory Content.fromJson(Map<String, dynamic> srcJson) => _$ContentFromJson(srcJson);

}


@JsonSerializable()
class Pageable extends Object with _$PageableSerializerMixin{

  @JsonKey(name: 'sort')
  Sort sort;

  @JsonKey(name: 'offset')
  int offset;

  @JsonKey(name: 'pageSize')
  int pageSize;

  @JsonKey(name: 'pageNumber')
  int pageNumber;

  @JsonKey(name: 'paged')
  bool paged;

  @JsonKey(name: 'unpaged')
  bool unpaged;

  Pageable(this.sort,this.offset,this.pageSize,this.pageNumber,this.paged,this.unpaged,);

  factory Pageable.fromJson(Map<String, dynamic> srcJson) => _$PageableFromJson(srcJson);

}


@JsonSerializable()
class Sort extends Object with _$SortSerializerMixin{

  @JsonKey(name: 'sorted')
  bool sorted;

  @JsonKey(name: 'unsorted')
  bool unsorted;

  @JsonKey(name: 'empty')
  bool empty;

  Sort(this.sorted,this.unsorted,this.empty,);

  factory Sort.fromJson(Map<String, dynamic> srcJson) => _$SortFromJson(srcJson);

}