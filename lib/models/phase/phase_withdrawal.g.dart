// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phase_withdrawal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WithdrawalPhaseAdapter extends TypeAdapter<WithdrawalPhase> {
  @override
  final int typeId = 206;

  @override
  WithdrawalPhase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WithdrawalPhase(
      letter: fields[1] as String,
    )..name = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, WithdrawalPhase obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.letter);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WithdrawalPhaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawalPhase _$WithdrawalPhaseFromJson(Map<String, dynamic> json) {
  return WithdrawalPhase(
    letter: json['letter'] as String,
  )..name = json['name'] as String;
}

Map<String, dynamic> _$WithdrawalPhaseToJson(WithdrawalPhase instance) =>
    <String, dynamic>{
      'name': instance.name,
      'letter': instance.letter,
    };
