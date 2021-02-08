// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'synced_measure.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SyncedMeasureAdapter extends TypeAdapter<SyncedMeasure> {
  @override
  final int typeId = 5;

  @override
  SyncedMeasure read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SyncedMeasure(
      id: fields[0] as String,
      name: fields[2] as String,
      description: fields[3] as String,
      aggregation: fields[4] as ValueAggregation,
      schedule: fields[5] as Schedule,
    )
      ..trackedHealthDataTypeName = fields[6] as String
      ..type = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, SyncedMeasure obj) {
    writer
      ..writeByte(7)
      ..writeByte(6)
      ..write(obj.trackedHealthDataTypeName)
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
      other is SyncedMeasureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
