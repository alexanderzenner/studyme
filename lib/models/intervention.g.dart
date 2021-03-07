// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intervention.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InterventionAdapter extends TypeAdapter<Intervention> {
  @override
  final int typeId = 101;

  @override
  Intervention read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Intervention(
      id: fields[1] as dynamic,
      type: fields[0] as dynamic,
      name: fields[2] as String,
      description: fields[3] as String,
      instructions: fields[4] as String,
      letter: fields[5] as String,
      schedule: fields[6] as Schedule,
    );
  }

  @override
  void write(BinaryWriter writer, Intervention obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.instructions)
      ..writeByte(5)
      ..write(obj.letter)
      ..writeByte(6)
      ..write(obj.schedule);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InterventionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Intervention _$InterventionFromJson(Map<String, dynamic> json) {
  return Intervention(
    id: json['id'],
    type: json['type'],
    name: json['name'] as String,
    description: json['description'] as String,
    instructions: json['instructions'] as String,
    letter: json['letter'] as String,
    schedule: json['schedule'] == null
        ? null
        : Schedule.fromJson(json['schedule'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$InterventionToJson(Intervention instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'instructions': instance.instructions,
      'letter': instance.letter,
      'schedule': instance.schedule,
    };
