import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/models/phases/phase_order.dart';

part 'phases.g.dart';

@JsonSerializable()
@HiveType(typeId: 201)
class Phases extends HiveObject {
  @HiveField(0)
  PhaseOrder phaseOrder;

  @HiveField(1)
  int phaseDuration;

  @HiveField(2)
  List<String> phaseSequence;

  @HiveField(3)
  int numberOfCycles;

  int get numberOfPhases => phaseSequence.length;

  Phases();

  Phases.createDefault() {
    this.phaseOrder = PhaseOrder.alternating;
    this.phaseDuration = 7;
    this.numberOfCycles = 2;
    _updatePhaseSequence();
  }

  Phases.clone(Phases schedule)
      : phaseOrder = schedule.phaseOrder,
        phaseDuration = schedule.phaseDuration,
        phaseSequence = schedule.phaseSequence,
        numberOfCycles = schedule.numberOfCycles;

  clone() {
    return Phases.clone(this);
  }

  int get totalDuration => phaseDuration * numberOfPhases;

  updatePhaseOrder(PhaseOrder newPhaseOrder) {
    phaseOrder = newPhaseOrder;
    _updatePhaseSequence();
  }

  updateNumberOfCycles(int newNumberOfCycles) {
    numberOfCycles = newNumberOfCycles;
    _updatePhaseSequence();
  }

  _updatePhaseSequence() {
    List<String> pair = ['a', 'b'];
    List<String> newPhaseSequence = [];

    for (int i = 0; i < numberOfCycles; i++) {
      newPhaseSequence.addAll(pair);
      if (phaseOrder == PhaseOrder.counterbalanced) {
        pair = pair.reversed.toList();
      }
    }
    phaseSequence = newPhaseSequence;
  }

  factory Phases.fromJson(Map<String, dynamic> json) => _$PhasesFromJson(json);
  Map<String, dynamic> toJson() => _$PhasesToJson(this);
}
