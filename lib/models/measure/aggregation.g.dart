// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aggregation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AggregationAdapter extends TypeAdapter<Aggregation> {
  @override
  final int typeId = 6;

  @override
  Aggregation read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Aggregation.Average;
      case 1:
        return Aggregation.Sum;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, Aggregation obj) {
    switch (obj) {
      case Aggregation.Average:
        writer.writeByte(0);
        break;
      case Aggregation.Sum:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AggregationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
