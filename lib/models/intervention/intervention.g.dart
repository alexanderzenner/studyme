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
    return Intervention()
      ..type = fields[0] as String
      ..id = fields[1] as String
      ..name = fields[2] as String
      ..description = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, Intervention obj) {
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
      other is InterventionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
