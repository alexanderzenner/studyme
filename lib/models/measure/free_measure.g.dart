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
      id: fields[0] as String,
      name: fields[2] as String,
      description: fields[3] as String,
      aggregation: fields[4] as ValueAggregation,
    )
      ..type = fields[1] as String
      ..schedule = fields[5] as Schedule;
  }

  @override
  void write(BinaryWriter writer, FreeMeasure obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.aggregation)
      ..writeByte(5)
      ..write(obj.schedule);
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
