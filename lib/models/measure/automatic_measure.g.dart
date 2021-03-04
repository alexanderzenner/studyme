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
      description: fields[3] as String,
      aggregation: fields[4] as ValueAggregation,
      schedule: fields[5] as Schedule,
    )
      ..trackedHealthDataTypeName = fields[6] as String
      ..type = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, AutomaticMeasure obj) {
    writer
      ..writeByte(7)
      ..writeByte(6)
      ..write(obj.trackedHealthDataTypeName)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.aggregation)
      ..writeByte(5)
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
    description: json['description'] as String,
    aggregation:
        _$enumDecodeNullable(_$ValueAggregationEnumMap, json['aggregation']),
    schedule: json['schedule'] == null
        ? null
        : Schedule.fromJson(json['schedule'] as Map<String, dynamic>),
  )
    ..type = json['type'] as String
    ..trackedHealthDataTypeName = json['trackedHealthDataTypeName'] as String;
}

Map<String, dynamic> _$AutomaticMeasureToJson(AutomaticMeasure instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'description': instance.description,
      'aggregation': _$ValueAggregationEnumMap[instance.aggregation],
      'schedule': instance.schedule,
      'trackedHealthDataTypeName': instance.trackedHealthDataTypeName,
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
