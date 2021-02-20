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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrialPhases _$TrialPhasesFromJson(Map<String, dynamic> json) {
  return TrialPhases()
    ..phaseOrder = _$enumDecodeNullable(_$PhaseOrderEnumMap, json['phaseOrder'])
    ..phaseDuration = json['phaseDuration'] as int
    ..phaseSequence =
        (json['phaseSequence'] as List)?.map((e) => e as String)?.toList()
    ..numberOfCycles = json['numberOfCycles'] as int;
}

Map<String, dynamic> _$TrialPhasesToJson(TrialPhases instance) =>
    <String, dynamic>{
      'phaseOrder': _$PhaseOrderEnumMap[instance.phaseOrder],
      'phaseDuration': instance.phaseDuration,
      'phaseSequence': instance.phaseSequence,
      'numberOfCycles': instance.numberOfCycles,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$PhaseOrderEnumMap = {
  PhaseOrder.alternating: 'alternating',
  PhaseOrder.counterbalanced: 'counterbalanced',
};
