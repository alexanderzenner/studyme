// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'free_measure.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FreeMeasureAdapter extends TypeAdapter<FreeMeasure> {
  @override
  final int typeId = 1;

  @override
  FreeMeasure read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FreeMeasure(
      id: fields[0] as dynamic,
      name: fields[2] as dynamic,
      description: fields[3] as dynamic,
    )..type = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, FreeMeasure obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
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
      other is FreeMeasureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}