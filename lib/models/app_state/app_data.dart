import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/app_state/default_measures.dart';
import 'package:studyme/util/notifications.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/reminder.dart';
import 'package:studyme/models/trial.dart';
import 'package:studyme/models/trial_schedule.dart';

class AppData extends ChangeNotifier {
  static const activeTrialKey = 'trial';
  static const stateKey = 'state';

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

  void setInterventionA(Intervention intervention) {
    _trial.a = intervention;
    _trial.save();
    notifyListeners();
  }

  void setInterventionB(Intervention intervention) {
    _trial.b = intervention;
    _trial.save();
    notifyListeners();
  }

  int _getIndexForId(List list, String id) {
    return list.indexWhere((i) => i.id == id);
  }

  void addMeasure(Measure measure) {
    _trial.measures.add(measure);
    _trial.save();
    notifyListeners();
  }

  void updateMeasure(Measure measure, Measure newMeasure) {
    var index = _getIndexForId(_trial.measures, measure.id);
    if (index >= 0) {
      _trial.measures[index] = newMeasure;
      _trial.save();
      notifyListeners();
    }
  }

  void removeMeasure(Measure measure) {
    var index = _getIndexForId(_trial.measures, measure.id);
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

  void updateReminder(Reminder reminder, Reminder newReminder) {
    var index = _getIndexForId(_trial.reminders, reminder.id);
    if (index >= 0) {
      _trial.reminders[index] = newReminder;
      _trial.save();
      notifyListeners();
    }
  }

  void removeReminder(Reminder reminder) {
    var index = _getIndexForId(_trial.reminders, reminder.id);
    if (index >= 0) {
      _trial.reminders.removeAt(index);
      _trial.save();
      notifyListeners();
    }
  }

  void addReminder(Reminder reminder) {
    _trial.reminders.add(reminder);
    _trial.save();
    notifyListeners();
  }

  loadAppState() async {
    box = await Hive.openBox('app_data');
    _trial = box.get(activeTrialKey);

    // first time app is started, initialize state and trial
    if (true || state == null) {
      saveAppState(AppState.ONBOARDING);
    }
    if (_trial == null) {
      createNewTrial();
    }
  }

  startTrial() {
    saveAppState(AppState.DOING);
    DateTime now = DateTime.now();
    _trial.startDate = DateTime(now.year, now.month, now.day);
    _trial.save();
    _trial.reminders.asMap().forEach((index, reminder) {
      Notifications().scheduleNotificationFor(reminder, index);
    });
  }

  saveAppState(AppState state) {
    box.put(stateKey, state);
  }

  createNewTrial() {
    _trial = Trial();
    box.put(activeTrialKey, _trial);
  }

  bool canAddSchedule() {
    return _trial.a != null && _trial.b != null;
  }

  bool canAddMeasures() {
    return canAddSchedule() && _trial.schedule != null;
  }

  bool canAddReminders() {
    return canAddMeasures() && _trial.measures.length > 0;
  }

  bool canStartTrial() {
    return canAddReminders();
  }
}
