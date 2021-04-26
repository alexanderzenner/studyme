// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scale_measure.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScaleMeasureAdapter extends TypeAdapter<ScaleMeasure> {
  @override
  final int typeId = 2;

  @override
  ScaleMeasure read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScaleMeasure(
      id: fields[0] as String,
      name: fields[2] as String,
      min: fields[5] as double,
      minLabel: fields[6] as String,
      max: fields[7] as double,
      maxLabel: fields[8] as String,
      schedule: fields[4] as Reminder,
    )
      ..initial = fields[9] as double
      ..type = fields[1] as String
      ..unit = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, ScaleMeasure obj) {
    writer
      ..writeByte(10)
      ..writeByte(5)
      ..write(obj.min)
      ..writeByte(6)
      ..write(obj.minLabel)
      ..writeByte(7)
      ..write(obj.max)
      ..writeByte(8)
      ..write(obj.maxLabel)
      ..writeByte(9)
      ..write(obj.initial)
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
      other is ScaleMeasureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScaleMeasure _$ScaleMeasureFromJson(Map<String, dynamic> json) {
  return ScaleMeasure(
    id: json['id'] as String,
    name: json['name'] as String,
    min: (json['min'] as num)?.toDouble(),
    minLabel: json['minLabel'] as String,
    max: (json['max'] as num)?.toDouble(),
    maxLabel: json['maxLabel'] as String,
    schedule: json['schedule'] == null
        ? null
        : Reminder.fromJson(json['schedule'] as Map<String, dynamic>),
  )
    ..type = json['type'] as String
    ..unit = json['unit'] as String
    ..initial = (json['initial'] as num)?.toDouble();
}

Map<String, dynamic> _$ScaleMeasureToJson(ScaleMeasure instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'unit': instance.unit,
      'schedule': instance.schedule,
      'min': instance.min,
      'minLabel': instance.minLabel,
      'max': instance.max,
      'maxLabel': instance.maxLabel,
      'initial': instance.initial,
    };
