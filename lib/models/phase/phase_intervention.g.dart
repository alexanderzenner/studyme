// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phase_intervention.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InterventionPhaseAdapter extends TypeAdapter<InterventionPhase> {
  @override
  final int typeId = 206;

  @override
  InterventionPhase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InterventionPhase(
      letter: fields[1] as String,
      intervention: fields[3] as Intervention,
    )..name = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, InterventionPhase obj) {
    writer
      ..writeByte(3)
      ..writeByte(3)
      ..write(obj.intervention)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.letter);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InterventionPhaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterventionPhase _$InterventionPhaseFromJson(Map<String, dynamic> json) {
  return InterventionPhase(
    letter: json['letter'] as String,
    intervention: json['intervention'] == null
        ? null
        : Intervention.fromJson(json['intervention'] as Map<String, dynamic>),
  )..name = json['name'] as String;
}

Map<String, dynamic> _$InterventionPhaseToJson(InterventionPhase instance) =>
    <String, dynamic>{
      'name': instance.name,
      'letter': instance.letter,
      'intervention': instance.intervention,
    };
