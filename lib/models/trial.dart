import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/models/phase/phase_intervention.dart';
import 'package:studyme/models/phase/phase.dart';
import 'package:studyme/models/phase/phase_withdrawal.dart';
import 'package:studyme/models/trial_schedule.dart';
import 'package:studyme/models/task/task.dart';
import 'package:studyme/models/trial_type.dart';
import 'package:studyme/util/time_of_day_extension.dart';

import './measure/measure.dart';
import 'intervention.dart';
import 'measure/automatic_measure.dart';
import 'goal.dart';

part 'trial.g.dart';

@JsonSerializable()
@HiveType(typeId: 200)
class Trial extends HiveObject {
  @HiveField(0)
  Goal goal;

  @HiveField(1)
  TrialType type;

  @HiveField(2)
  Intervention interventionA;

  @HiveField(3)
  Intervention interventionB;

  @HiveField(4)
  Phase a;

  @HiveField(5)
  Phase b;

  @HiveField(6)
  List<Measure> measures;

  @HiveField(7)
  TrialSchedule schedule;

  @HiveField(8)
  DateTime startDate;

  @HiveField(9)
  Map<DateTime, String> stepsLogForSurvey;

  List<Task> getTasksForDate(DateTime date) {
    DateTime _cleanDate = DateTime(date.year, date.month, date.day);
    List<Task> _tasks = [];

    if (date.isAfter(startDate) && date.isBefore(endDate)) {
      int daysSinceBeginningOfTrial = _cleanDate.difference(startDate).inDays;
      int daysSinceBeginningOfPhase =
          daysSinceBeginningOfTrial % schedule.phaseDuration;

      Phase _phase = getPhaseForDate(_cleanDate);

      _tasks.addAll(_phase.getTasksFor(daysSinceBeginningOfPhase));
      measures.forEach((measure) {
        _tasks.addAll(measure.getTasksFor(daysSinceBeginningOfTrial));
      });

      _tasks.sort((a, b) {
        if (a.time.combined < b.time.combined) {
          return -1;
        } else if (a.time.combined > b.time.combined) {
          return 1;
        } else {
          return 0;
        }
      });
    } else {
      print("experiment has ended");
    }

    return _tasks;
  }

  List<AutomaticMeasure> get syncedMeasures {
    return measures.whereType<AutomaticMeasure>().toList();
  }

  Trial()
      : this.measures = [],
        this.stepsLogForSurvey = {};

  DateTime get endDate {
    return startDate
        .add(Duration(days: schedule.totalDuration))
        .subtract(Duration(seconds: 1));
  }

  int getDayOfStudyFor(DateTime date) {
    return date.differenceInDays(startDate).inDays;
  }

  bool isInStudyTimeframe(DateTime date) {
    return date.isAfter(startDate) && date.isBefore(endDate);
  }

  Phase getPhaseForDate(DateTime date) {
    final index = getPhaseIndexForDate(date);

    return getPhaseForPhaseIndex(index);
  }

  Phase getPhaseForPhaseIndex(int index) {
    if (index < 0 || index >= schedule.numberOfPhases) {
      print('trial is over or has not begun.');
      return null;
    }
    final _letter = schedule.phaseSequence[index];

    if (_letter == 'a')
      return a;
    else if (_letter == 'b')
      return b;
    else
      return null;
  }

  int getPhaseIndexForDate(DateTime date) {
    final test = date.differenceInDays(startDate).inDays;
    return test ~/ schedule.phaseDuration;
  }

  generateWithSetInfos() {
    this.schedule = TrialSchedule.createDefault();
    if (this.type == TrialType.Reversal) {
      this.a = WithdrawalPhase.fromIntervention(
          letter: 'a', withdrawnIntervention: this.interventionA);
      this.b = InterventionPhase(letter: 'b', intervention: this.interventionA);
    } else {
      this.a = InterventionPhase(letter: 'a', intervention: this.interventionA);
      this.b = InterventionPhase(letter: 'b', intervention: this.interventionB);
    }
  }

  factory Trial.fromJson(Map<String, dynamic> json) => _$TrialFromJson(json);
  Map<String, dynamic> toJson() => _$TrialToJson(this);
}

extension DateOnlyCompare on DateTime {
  // needed for models
  Duration differenceInDays(DateTime other) {
    final currentZero = DateTime(year, month, day);
    final otherZero = DateTime(other.year, other.month, other.day);
    return currentZero.difference(otherZero);
  }
}
