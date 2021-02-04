// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choice_measure.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChoiceMeasureAdapter extends TypeAdapter<ChoiceMeasure> {
  @override
  final int typeId = 3;

  @override
  ChoiceMeasure read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChoiceMeasure(
      id: fields[0] as dynamic,
      name: fields[2] as dynamic,
      description: fields[3] as dynamic,
      choices: (fields[5] as List)?.cast<Choice>(),
    )
      ..type = fields[1] as String
      ..aggregationString = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, ChoiceMeasure obj) {
    writer
      ..writeByte(6)
      ..writeByte(5)
      ..write(obj.choices)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.aggregationString);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChoiceMeasureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
