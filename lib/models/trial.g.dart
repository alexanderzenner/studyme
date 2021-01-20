// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trial.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrialAdapter extends TypeAdapter<Trial> {
  @override
  final int typeId = 200;

  @override
  Trial read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Trial()
      ..a = fields[0] as AbstractIntervention
      ..b = fields[1] as AbstractIntervention
      ..measures = (fields[2] as List)?.cast<Measure>()
      ..schedule = fields[3] as TrialSchedule
      ..startDate = fields[4] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Trial obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.a)
      ..writeByte(1)
      ..write(obj.b)
      ..writeByte(2)
      ..write(obj.measures)
      ..writeByte(3)
      ..write(obj.schedule)
      ..writeByte(4)
      ..write(obj.startDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrialAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
