// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trial_phases.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrialPhasesAdapter extends TypeAdapter<TrialPhases> {
  @override
  final int typeId = 201;

  @override
  TrialPhases read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrialPhases()
      ..phaseOrder = fields[0] as PhaseOrder
      ..phaseDuration = fields[1] as int
      ..phaseSequence = (fields[2] as List)?.cast<String>()
      ..numberOfCycles = fields[3] as int;
  }

  @override
  void write(BinaryWriter writer, TrialPhases obj) {
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
      other is TrialPhasesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
