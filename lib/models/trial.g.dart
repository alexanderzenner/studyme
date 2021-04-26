// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trial.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrialAdapter extends TypeAdapter<Trial> {
  @override
  final int typeId = 200;

  @override
  Trial read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Trial()
      ..goal = fields[0] as Goal
      ..type = fields[1] as TrialType
      ..interventionA = fields[2] as Intervention
      ..interventionB = fields[3] as Intervention
      ..a = fields[4] as Phase
      ..b = fields[5] as Phase
      ..measures = (fields[6] as List)?.cast<Measure>()
      ..schedule = fields[7] as TrialSchedule
      ..startDate = fields[8] as DateTime
      ..stepsLogForSurvey = (fields[9] as Map)?.cast<DateTime, String>();
  }

  @override
  void write(BinaryWriter writer, Trial obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.goal)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.interventionA)
      ..writeByte(3)
      ..write(obj.interventionB)
      ..writeByte(4)
      ..write(obj.a)
      ..writeByte(5)
      ..write(obj.b)
      ..writeByte(6)
      ..write(obj.measures)
      ..writeByte(7)
      ..write(obj.schedule)
      ..writeByte(8)
      ..write(obj.startDate)
      ..writeByte(9)
      ..write(obj.stepsLogForSurvey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrialAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trial _$TrialFromJson(Map<String, dynamic> json) {
  return Trial()
    ..goal = json['goal'] == null
        ? null
        : Goal.fromJson(json['goal'] as Map<String, dynamic>)
    ..type = _$enumDecodeNullable(_$TrialTypeEnumMap, json['type'])
    ..interventionA = json['interventionA'] == null
        ? null
        : Intervention.fromJson(json['interventionA'] as Map<String, dynamic>)
    ..interventionB = json['interventionB'] == null
        ? null
        : Intervention.fromJson(json['interventionB'] as Map<String, dynamic>)
    ..a = json['a'] == null
        ? null
        : Phase.fromJson(json['a'] as Map<String, dynamic>)
    ..b = json['b'] == null
        ? null
        : Phase.fromJson(json['b'] as Map<String, dynamic>)
    ..measures = (json['measures'] as List)
        ?.map((e) =>
            e == null ? null : Measure.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..schedule = json['schedule'] == null
        ? null
        : TrialSchedule.fromJson(json['schedule'] as Map<String, dynamic>)
    ..startDate = json['startDate'] == null
        ? null
        : DateTime.parse(json['startDate'] as String)
    ..stepsLogForSurvey =
        (json['stepsLogForSurvey'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(DateTime.parse(k), e as String),
    );
}

Map<String, dynamic> _$TrialToJson(Trial instance) => <String, dynamic>{
      'goal': instance.goal,
      'type': _$TrialTypeEnumMap[instance.type],
      'interventionA': instance.interventionA,
      'interventionB': instance.interventionB,
      'a': instance.a,
      'b': instance.b,
      'measures': instance.measures,
      'schedule': instance.schedule,
      'startDate': instance.startDate?.toIso8601String(),
      'stepsLogForSurvey': instance.stepsLogForSurvey
          ?.map((k, e) => MapEntry(k.toIso8601String(), e)),
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

const _$TrialTypeEnumMap = {
  TrialType.reversal: 'reversal',
  TrialType.alternatingTreatment: 'alternatingTreatment',
};
