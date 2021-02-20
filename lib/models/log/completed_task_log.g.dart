// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completed_task_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompletedTaskLogAdapter extends TypeAdapter<CompletedTaskLog> {
  @override
  final int typeId = 51;

  @override
  CompletedTaskLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompletedTaskLog()
      ..taskId = fields[0] as String
      ..dateTime = fields[1] as DateTime;
  }

  @override
  void write(BinaryWriter writer, CompletedTaskLog obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.taskId)
      ..writeByte(1)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompletedTaskLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
