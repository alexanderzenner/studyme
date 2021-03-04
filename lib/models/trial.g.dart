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
      ..outcome = fields[0] as Outcome
      ..type = fields[1] as TrialType
      ..interventionA = fields[2] as Intervention
      ..interventionB = fields[3] as Intervention
      ..measures = (fields[4] as List)?.cast<Measure>()
      ..schedule = fields[5] as TrialSchedule
      ..startDate = fields[6] as DateTime
      ..stepsLogForSurvey = (fields[7] as Map)?.cast<DateTime, String>();
  }

  @override
  void write(BinaryWriter writer, Trial obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.outcome)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.interventionA)
      ..writeByte(3)
      ..write(obj.interventionB)
      ..writeByte(4)
      ..write(obj.measures)
      ..writeByte(5)
      ..write(obj.schedule)
      ..writeByte(6)
      ..write(obj.startDate)
      ..writeByte(7)
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
    ..outcome = json['outcome'] == null
        ? null
        : Outcome.fromJson(json['outcome'] as Map<String, dynamic>)
    ..type = _$enumDecodeNullable(_$TrialTypeEnumMap, json['type'])
    ..interventionA = json['interventionA'] == null
        ? null
        : Intervention.fromJson(json['interventionA'] as Map<String, dynamic>)
    ..interventionB = json['interventionB'] == null
        ? null
        : Intervention.fromJson(json['interventionB'] as Map<String, dynamic>)
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
      'outcome': instance.outcome,
      'type': _$TrialTypeEnumMap[instance.type],
      'interventionA': instance.interventionA,
      'interventionB': instance.interventionB,
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
  TrialType.introductionWithdrawal: 'introductionWithdrawal',
  TrialType.alternativeTreatment: 'alternativeTreatment',
};
