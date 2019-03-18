// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomList _$RoomListFromJson(Map<String, dynamic> json) {
  return new RoomList(
      json['code'] as int,
      json['extras'] == null
          ? null
          : new Extras.fromJson(json['extras'] as Map<String, dynamic>));
}

abstract class _$RoomListSerializerMixin {
  int get code;
  Extras get extras;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'code': code, 'extras': extras};
}

Extras _$ExtrasFromJson(Map<String, dynamic> json) {
  return new Extras(json['rooms'] == null
      ? null
      : new Rooms.fromJson(json['rooms'] as Map<String, dynamic>));
}

abstract class _$ExtrasSerializerMixin {
  Rooms get rooms;
  Map<String, dynamic> toJson() => <String, dynamic>{'rooms': rooms};
}

Rooms _$RoomsFromJson(Map<String, dynamic> json) {
  return new Rooms(
      (json['content'] as List)
          ?.map((e) => e == null
              ? null
              : new Content.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['pageable'] == null
          ? null
          : new Pageable.fromJson(json['pageable'] as Map<String, dynamic>),
      json['last'] as bool,
      json['totalPages'] as int,
      json['totalElements'] as int,
      json['number'] as int,
      json['sort'] == null
          ? null
          : new Sort.fromJson(json['sort'] as Map<String, dynamic>),
      json['size'] as int,
      json['first'] as bool,
      json['numberOfElements'] as int,
      json['empty'] as bool);
}

abstract class _$RoomsSerializerMixin {
  List<Content> get content;
  Pageable get pageable;
  bool get last;
  int get totalPages;
  int get totalElements;
  int get number;
  Sort get sort;
  int get size;
  bool get first;
  int get numberOfElements;
  bool get empty;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'content': content,
        'pageable': pageable,
        'last': last,
        'totalPages': totalPages,
        'totalElements': totalElements,
        'number': number,
        'sort': sort,
        'size': size,
        'first': first,
        'numberOfElements': numberOfElements,
        'empty': empty
      };
}

Content _$ContentFromJson(Map<String, dynamic> json) {
  return new Content(
      json['id'] as int,
      json['name'] as String,
      json['location'] as String,
      json['capacity'] as int,
      json['available'] as bool,
      json['microphoneAvailable'] as bool,
      json['projectorAvailable'] as bool);
}

abstract class _$ContentSerializerMixin {
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

Pageable _$PageableFromJson(Map<String, dynamic> json) {
  return new Pageable(
      json['sort'] == null
          ? null
          : new Sort.fromJson(json['sort'] as Map<String, dynamic>),
      json['offset'] as int,
      json['pageSize'] as int,
      json['pageNumber'] as int,
      json['paged'] as bool,
      json['unpaged'] as bool);
}

abstract class _$PageableSerializerMixin {
  Sort get sort;
  int get offset;
  int get pageSize;
  int get pageNumber;
  bool get paged;
  bool get unpaged;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sort': sort,
        'offset': offset,
        'pageSize': pageSize,
        'pageNumber': pageNumber,
        'paged': paged,
        'unpaged': unpaged
      };
}

Sort _$SortFromJson(Map<String, dynamic> json) {
  return new Sort(
      json['sorted'] as bool, json['unsorted'] as bool, json['empty'] as bool);
}

abstract class _$SortSerializerMixin {
  bool get sorted;
  bool get unsorted;
  bool get empty;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'sorted': sorted, 'unsorted': unsorted, 'empty': empty};
}
