// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'abstract_intervention.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AbstractInterventionAdapter extends TypeAdapter<AbstractIntervention> {
  @override
  final int typeId = 100;

  @override
  AbstractIntervention read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AbstractIntervention(
      fields[0] as String,
    )
      ..id = fields[1] as String
      ..name = fields[2] as String
      ..description = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, AbstractIntervention obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AbstractInterventionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
