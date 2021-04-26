// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trial_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrialTypeAdapter extends TypeAdapter<TrialType> {
  @override
  final int typeId = 205;

  @override
  TrialType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TrialType.reversal;
      case 1:
        return TrialType.alternatingTreatment;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, TrialType obj) {
    switch (obj) {
      case TrialType.reversal:
        writer.writeByte(0);
        break;
      case TrialType.alternatingTreatment:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrialTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
