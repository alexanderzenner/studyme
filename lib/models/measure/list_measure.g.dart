// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_measure.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListMeasureAdapter extends TypeAdapter<ListMeasure> {
  @override
  final int typeId = 3;

  @override
  ListMeasure read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListMeasure(
      id: fields[0] as String,
      name: fields[2] as String,
      items: (fields[5] as List)?.cast<ListItem>(),
      schedule: fields[4] as Reminder,
    )
      ..type = fields[1] as String
      ..unit = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, ListMeasure obj) {
    writer
      ..writeByte(6)
      ..writeByte(5)
      ..write(obj.items)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.unit)
      ..writeByte(4)
      ..write(obj.schedule);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListMeasureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListMeasure _$ListMeasureFromJson(Map<String, dynamic> json) {
  return ListMeasure(
    id: json['id'] as String,
    name: json['name'] as String,
    items: (json['items'] as List)
        ?.map((e) =>
            e == null ? null : ListItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    schedule: json['schedule'] == null
        ? null
        : Reminder.fromJson(json['schedule'] as Map<String, dynamic>),
  )
    ..type = json['type'] as String
    ..unit = json['unit'] as String;
}

Map<String, dynamic> _$ListMeasureToJson(ListMeasure instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'unit': instance.unit,
      'schedule': instance.schedule,
      'items': instance.items,
    };
