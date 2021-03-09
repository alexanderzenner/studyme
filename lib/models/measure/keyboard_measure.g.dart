// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyboard_measure.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KeyboardMeasureAdapter extends TypeAdapter<KeyboardMeasure> {
  @override
  final int typeId = 1;

  @override
  KeyboardMeasure read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KeyboardMeasure(
      id: fields[0] as String,
      name: fields[2] as String,
      unit: fields[3] as String,
      schedule: fields[4] as Schedule,
    )..type = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, KeyboardMeasure obj) {
    writer
      ..writeByte(5)
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
      other is KeyboardMeasureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeyboardMeasure _$KeyboardMeasureFromJson(Map<String, dynamic> json) {
  return KeyboardMeasure(
    id: json['id'] as String,
    name: json['name'] as String,
    unit: json['unit'] as String,
    schedule: json['schedule'] == null
        ? null
        : Schedule.fromJson(json['schedule'] as Map<String, dynamic>),
  )..type = json['type'] as String;
}

Map<String, dynamic> _$KeyboardMeasureToJson(KeyboardMeasure instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'unit': instance.unit,
      'schedule': instance.schedule,
    };
