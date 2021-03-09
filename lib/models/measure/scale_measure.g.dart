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
      description: fields[3] as String,
      min: fields[7] as double,
      minLabel: fields[8] as String,
      max: fields[9] as double,
      maxLabel: fields[10] as String,
      aggregation: fields[5] as ValueAggregation,
      schedule: fields[6] as Schedule,
    )
      ..initial = fields[11] as double
      ..type = fields[1] as String
      ..unit = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, ScaleMeasure obj) {
    writer
      ..writeByte(12)
      ..writeByte(7)
      ..write(obj.min)
      ..writeByte(8)
      ..write(obj.minLabel)
      ..writeByte(9)
      ..write(obj.max)
      ..writeByte(10)
      ..write(obj.maxLabel)
      ..writeByte(11)
      ..write(obj.initial)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.unit)
      ..writeByte(5)
      ..write(obj.aggregation)
      ..writeByte(6)
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
    description: json['description'] as String,
    min: (json['min'] as num)?.toDouble(),
    minLabel: json['minLabel'] as String,
    max: (json['max'] as num)?.toDouble(),
    maxLabel: json['maxLabel'] as String,
    aggregation:
        _$enumDecodeNullable(_$ValueAggregationEnumMap, json['aggregation']),
    schedule: json['schedule'] == null
        ? null
        : Schedule.fromJson(json['schedule'] as Map<String, dynamic>),
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
      'description': instance.description,
      'unit': instance.unit,
      'aggregation': _$ValueAggregationEnumMap[instance.aggregation],
      'schedule': instance.schedule,
      'min': instance.min,
      'minLabel': instance.minLabel,
      'max': instance.max,
      'maxLabel': instance.maxLabel,
      'initial': instance.initial,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$ValueAggregationEnumMap = {
  ValueAggregation.Average: 'Average',
  ValueAggregation.Sum: 'Sum',
};
