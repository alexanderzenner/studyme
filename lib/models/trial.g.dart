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
      ..a = fields[0] as Intervention
      ..b = fields[1] as Intervention
      ..measures = (fields[2] as List)?.cast<Measure>()
      ..phases = fields[3] as TrialPhases
      ..startDate = fields[4] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Trial obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.a)
      ..writeByte(1)
      ..write(obj.b)
      ..writeByte(2)
      ..write(obj.measures)
      ..writeByte(3)
      ..write(obj.phases)
      ..writeByte(4)
      ..write(obj.startDate);
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
    ..a = json['a'] == null
        ? null
        : Intervention.fromJson(json['a'] as Map<String, dynamic>)
    ..b = json['b'] == null
        ? null
        : Intervention.fromJson(json['b'] as Map<String, dynamic>)
    ..measures = (json['measures'] as List)
        ?.map((e) =>
            e == null ? null : Measure.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..phases = json['phases'] == null
        ? null
        : TrialPhases.fromJson(json['phases'] as Map<String, dynamic>)
    ..startDate = json['startDate'] == null
        ? null
        : DateTime.parse(json['startDate'] as String);
}

Map<String, dynamic> _$TrialToJson(Trial instance) => <String, dynamic>{
      'a': instance.a,
      'b': instance.b,
      'measures': instance.measures,
      'phases': instance.phases,
      'startDate': instance.startDate?.toIso8601String(),
    };
