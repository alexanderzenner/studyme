// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trial_schedule.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhaseOrderAdapter extends TypeAdapter<PhaseOrder> {
  @override
  final int typeId = 202;

  @override
  PhaseOrder read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PhaseOrder.alternating;
      case 1:
        return PhaseOrder.counterbalanced;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, PhaseOrder obj) {
    switch (obj) {
      case PhaseOrder.alternating:
        writer.writeByte(0);
        break;
      case PhaseOrder.counterbalanced:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhaseOrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TrialScheduleAdapter extends TypeAdapter<TrialSchedule> {
  @override
  final int typeId = 201;

  @override
  TrialSchedule read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrialSchedule(
      phaseOrder: fields[0] as PhaseOrder,
      phaseDuration: fields[1] as int,
      numberOfCycles: fields[3] as int,
    )..phaseSequence = (fields[2] as List)?.cast<String>();
  }

  @override
  void write(BinaryWriter writer, TrialSchedule obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.phaseOrder)
      ..writeByte(1)
      ..write(obj.phaseDuration)
      ..writeByte(2)
      ..write(obj.phaseSequence)
      ..writeByte(3)
      ..write(obj.numberOfCycles);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrialScheduleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
