import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/phase/phase.dart';

part 'phase_intervention.g.dart';

@JsonSerializable()
@HiveType(typeId: 206)
class InterventionPhase extends Phase {
  @HiveField(3)
  Intervention intervention;

  InterventionPhase({String letter, Intervention intervention})
      : this.intervention = intervention,
        super(name: intervention.name, letter: letter);

  factory InterventionPhase.fromJson(Map<String, dynamic> json) =>
      _$InterventionPhaseFromJson(json);
  Map<String, dynamic> toJson() => _$InterventionPhaseToJson(this);
}
