// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measure_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MeasureLogAdapter extends TypeAdapter<MeasureLog> {
  @override
  final int typeId = 51;

  @override
  MeasureLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MeasureLog(
      fields[1] as dynamic,
      fields[2] as dynamic,
      fields[3] as dynamic,
    )..type = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, MeasureLog obj) {
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
      other is MeasureLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
