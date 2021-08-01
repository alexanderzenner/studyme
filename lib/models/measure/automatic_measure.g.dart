// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'automatic_measure.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AutomaticMeasureAdapter extends TypeAdapter<AutomaticMeasure> {
  @override
  final int typeId = 5;

  @override
  AutomaticMeasure read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AutomaticMeasure(
      id: fields[0] as String,
      name: fields[2] as String,
      unit: fields[3] as String,
      schedule: fields[4] as Reminder,
    )
      ..trackedHealthDataTypeName = fields[5] as String
      ..type = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, AutomaticMeasure obj) {
    writer
      ..writeByte(6)
      ..writeByte(5)
      ..write(obj.trackedHealthDataTypeName)
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
      other is AutomaticMeasureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutomaticMeasure _$AutomaticMeasureFromJson(Map<String, dynamic> json) {
  return AutomaticMeasure(
    id: json['id'] as String,
    name: json['name'] as String,
    unit: json['unit'] as String,
    schedule: json['schedule'] == null
        ? null
        : Reminder.fromJson(json['schedule'] as Map<String, dynamic>),
  )
    ..type = json['type'] as String
    ..trackedHealthDataTypeName = json['trackedHealthDataTypeName'] as String;
}

Map<String, dynamic> _$AutomaticMeasureToJson(AutomaticMeasure instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'unit': instance.unit,
      'schedule': instance.schedule,
      'trackedHealthDataTypeName': instance.trackedHealthDataTypeName,
    };
