import 'package:hive/hive.dart';
import 'package:studyme/models/schedule/phase_order.dart';

part 'trial_schedule.g.dart';

@HiveType(typeId: 201)
class TrialSchedule extends HiveObject {
  @HiveField(0)
  PhaseOrder phaseOrder;

  @HiveField(1)
  int phaseDuration;

  @HiveField(2)
  List<String> phaseSequence;

  @HiveField(3)
  int numberOfCycles;

  TrialSchedule();

  TrialSchedule.createDefault() {
    this.phaseOrder = PhaseOrder.alternating;
    this.phaseDuration = 7;
    this.numberOfCycles = 2;
    _updatePhaseSequence();
  }

  TrialSchedule.clone(TrialSchedule schedule)
      : phaseOrder = schedule.phaseOrder,
        phaseDuration = schedule.phaseDuration,
        phaseSequence = schedule.phaseSequence,
        numberOfCycles = schedule.numberOfCycles;

  clone() {
    return TrialSchedule.clone(this);
  }

  int get duration => phaseDuration * phaseSequence.length;

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
}
