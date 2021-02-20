// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'no_intervention.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoInterventionAdapter extends TypeAdapter<NoIntervention> {
  @override
  final int typeId = 102;

  @override
  NoIntervention read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoIntervention()
      ..name = fields[2] as String
      ..description = fields[3] as String
      ..schedule = fields[5] as Schedule
      ..type = fields[0] as String
      ..id = fields[1] as String
      ..letter = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, NoIntervention obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.letter);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoInterventionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoIntervention _$NoInterventionFromJson(Map<String, dynamic> json) {
  return NoIntervention()
    ..type = json['type'] as String
    ..id = json['id'] as String
    ..letter = json['letter'] as String
    ..name = json['name'] as String
    ..description = json['description'] as String
    ..schedule = json['schedule'] == null
        ? null
        : Schedule.fromJson(json['schedule'] as Map<String, dynamic>);
}

Map<String, dynamic> _$NoInterventionToJson(NoIntervention instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'letter': instance.letter,
      'name': instance.name,
      'description': instance.description,
      'schedule': instance.schedule,
    };
