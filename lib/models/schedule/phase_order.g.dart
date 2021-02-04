// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phase_order.dart';

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
