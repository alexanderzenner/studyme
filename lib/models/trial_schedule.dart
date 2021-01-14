class TrialSchedule {
  int phaseDuration;
  List<String> phaseSequence;
  int get duration => phaseDuration * phaseSequence.length;
}
