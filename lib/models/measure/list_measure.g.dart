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
      description: fields[3] as String,
      items: (fields[7] as List)?.cast<ListItem>(),
      aggregation: fields[5] as ValueAggregation,
      schedule: fields[6] as Schedule,
    )
      ..type = fields[1] as String
      ..unit = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, ListMeasure obj) {
    writer
      ..writeByte(8)
      ..writeByte(7)
      ..write(obj.items)
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
    description: json['description'] as String,
    items: (json['items'] as List)
        ?.map((e) =>
            e == null ? null : ListItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    aggregation:
        _$enumDecodeNullable(_$ValueAggregationEnumMap, json['aggregation']),
    schedule: json['schedule'] == null
        ? null
        : Schedule.fromJson(json['schedule'] as Map<String, dynamic>),
  )
    ..type = json['type'] as String
    ..unit = json['unit'] as String;
}

Map<String, dynamic> _$ListMeasureToJson(ListMeasure instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'description': instance.description,
      'unit': instance.unit,
      'aggregation': _$ValueAggregationEnumMap[instance.aggregation],
      'schedule': instance.schedule,
      'items': instance.items,
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
