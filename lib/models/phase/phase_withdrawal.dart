import 'package:hive/hive.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/phase/phase.dart';

import 'package:json_annotation/json_annotation.dart';

part 'phase_withdrawal.g.dart';

@JsonSerializable()
@HiveType(typeId: 206)
class WithdrawalPhase extends Phase {
  WithdrawalPhase({String letter, Intervention withdrawnIntervention})
      : super(name: 'Without "${withdrawnIntervention.name}"', letter: letter);

  factory WithdrawalPhase.fromJson(Map<String, dynamic> json) =>
      _$WithdrawalPhaseFromJson(json);
  Map<String, dynamic> toJson() => _$WithdrawalPhaseToJson(this);
}
