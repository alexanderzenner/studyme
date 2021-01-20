// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intervention_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InterventionLogAdapter extends TypeAdapter<InterventionLog> {
  @override
  final int typeId = 50;

  @override
  InterventionLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InterventionLog(
      fields[1] as dynamic,
      fields[2] as dynamic,
      fields[3] as dynamic,
    )..type = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, InterventionLog obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.loggedItemId)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InterventionLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
