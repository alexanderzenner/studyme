// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outcome.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OutcomeAdapter extends TypeAdapter<Outcome> {
  @override
  final int typeId = 203;

  @override
  Outcome read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Outcome(
      id: fields[0] as dynamic,
      outcome: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Outcome obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.outcome);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OutcomeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Outcome _$OutcomeFromJson(Map<String, dynamic> json) {
  return Outcome(
    id: json['id'],
    outcome: json['outcome'] as String,
    suggestedInterventions: json['suggestedInterventions'],
  );
}

Map<String, dynamic> _$OutcomeToJson(Outcome instance) => <String, dynamic>{
      'id': instance.id,
      'outcome': instance.outcome,
      'suggestedInterventions': instance.suggestedInterventions,
    };
