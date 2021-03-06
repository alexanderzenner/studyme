import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/app_state/default_measures.dart';
import 'package:studyme/models/intervention.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/trial_schedule.dart';
import 'package:studyme/models/task/task.dart';
import 'package:studyme/models/trial.dart';
import 'package:studyme/models/trial_type.dart';
import 'package:studyme/util/notifications.dart';
import 'package:studyme/util/time_of_day_extension.dart';

import '../goal.dart';

class AppData extends ChangeNotifier {
  static const activeTrialKey = 'trial';
  static const stateKey = 'state';
  static const lastDateWithScheduledNotificationsKey =
      'lastDateWithScheduledNotifications';
  static const notificationIdCounterKey = 'notificationIdCounterKey';
  static const interventionALetter = 'a';
  static const interventionBLetter = 'b';

  Box box;
  Trial _trial;
  List<Measure> _measures;

  AppState get state => box.get(stateKey);
  Trial get trial => _trial;
  List<Measure> get measures => _measures;

  List<Measure> get unaddedMeasures {
    List<Measure> measures = defaultMeasures;
    measures.removeWhere(
        (i) => _trial.measures.map((x) => x.id).toList().contains(i.id));
    return measures;
  }

  loadAppState() async {
    box = await Hive.openBox('app_data');
    _trial = box.get(activeTrialKey);

    // first time app is started, initialize state and trial
    if (state == null) {
      saveAppState(AppState.ONBOARDING);
    }
    if (_trial == null) {
      createNewTrial();
    }
  }

  void addStepLogForSurvey(String logMessage) {
    _trial.stepsLogForSurvey[DateTime.now()] = logMessage;
    _trial.save();
  }

  void setGoal(Goal goal) {
    _trial.goal = goal;
    _trial.save();
    notifyListeners();
  }

  void setTrialType(TrialType type) {
    _trial.type = type;

    _trial.save();
    notifyListeners();
  }

  void setInterventionA(Intervention intervention) {
    _trial.interventionA = intervention;
    _trial.save();
    notifyListeners();
  }

  void setInterventionB(Intervention intervention) {
    _trial.interventionB = intervention;
    _trial.save();
    notifyListeners();
  }

  void addMeasure(Measure measure) {
    _trial.measures.add(measure);
    _trial.save();
    notifyListeners();
  }

  void updateMeasure(int index, Measure newMeasure) {
    if (index >= 0) {
      _trial.measures[index] = newMeasure;
      _trial.save();
      notifyListeners();
    }
  }

  void removeMeasure(int index) {
    if (index >= 0) {
      _trial.measures.removeAt(index);
      _trial.save();
      notifyListeners();
    }
  }

  void updateSchedule(TrialSchedule schedule) {
    _trial.schedule = schedule;
    _trial.save();
    notifyListeners();
  }

  createNewTrial() {
    _trial = Trial();
    box.put(activeTrialKey, _trial);
  }

  finishEditingDetails() {
    saveAppState(AppState.CREATING_PHASES);
    _trial.generateWithSetInfos();
    _trial.save();
  }

  startTrial() {
    saveAppState(AppState.DOING);
    DateTime now = DateTime.now();
    _trial.startDate = DateTime(now.year, now.month, now.day);
    _trial.save();
    scheduleNotificationsFor(now);
  }

  saveAppState(AppState state) {
    box.put(stateKey, state);
  }

  void scheduleNotificationsFor(DateTime date) async {
    DateTime _latest = box.get(lastDateWithScheduledNotificationsKey);

    int _id = box.get(notificationIdCounterKey) ?? 0;
    // check that we haven't already scheduled notifications up to this date
    // clean the date, so comparison is based on day alone and not specific time
    DateTime _cleanDate = DateTime(date.year, date.month, date.day);
    if (_latest == null || _latest.isBefore(date)) {
      List<Task> tasks = _trial.getTasksForDate(date);

      if (date.difference(DateTime.now()).inDays == 0) {
        tasks.removeWhere(
            (element) => element.time.combined < element.time.combined);
      }
      tasks.forEach((task) {
        Notifications().scheduleNotificationFor(date, task, _id);
        _id++;
      });
      box.put(lastDateWithScheduledNotificationsKey, _cleanDate);
      box.put(notificationIdCounterKey, _id);
    }
  }

  void cancelAllNotifications() {
    Notifications().clearAll();
    box.put(lastDateWithScheduledNotificationsKey, null);
    box.put(notificationIdCounterKey, null);
  }

  bool canDefineInterventions() {
    return _trial.goal != null;
  }

  bool canDefineMeasures() {
    return canDefineInterventions() &&
        ((_trial.type == TrialType.reversal && _trial.interventionA != null) ||
            (_trial.type == TrialType.alternatingTreatment &&
                _trial.interventionA != null &&
                _trial.interventionB != null));
  }

  bool canStartTrial() {
    return canDefineMeasures() && _trial.measures.length > 0;
  }
}
