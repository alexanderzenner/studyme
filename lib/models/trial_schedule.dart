class TrialSchedule {
  PhaseOrder phaseOrder;
  int phaseDuration;
  List<String> phaseSequence;
  int numberOfCycles;

  TrialSchedule();

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

enum PhaseOrder { alternating, counterbalanced }

extension PhaseOrderExtension on PhaseOrder {
  String get humanReadable {
    switch (this) {
      case PhaseOrder.alternating:
        return 'Alternating';
      case PhaseOrder.counterbalanced:
        return 'Counterbalanced';
      default:
        return '';
    }
  }
}
