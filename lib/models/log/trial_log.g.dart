// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trial_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrialLogAdapter extends TypeAdapter<TrialLog> {
  @override
  final int typeId = 50;

  @override
  TrialLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrialLog(
      fields[0] as String,
      fields[1] as DateTime,
      fields[2] as num,
    );
  }

  @override
  void write(BinaryWriter writer, TrialLog obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.loggedItemId)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrialLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
