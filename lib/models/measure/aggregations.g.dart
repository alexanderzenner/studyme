// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aggregations.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ValueAggregationAdapter extends TypeAdapter<ValueAggregation> {
  @override
  final int typeId = 6;

  @override
  ValueAggregation read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ValueAggregation.Average;
      case 1:
        return ValueAggregation.Sum;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, ValueAggregation obj) {
    switch (obj) {
      case ValueAggregation.Average:
        writer.writeByte(0);
        break;
      case ValueAggregation.Sum:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValueAggregationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
