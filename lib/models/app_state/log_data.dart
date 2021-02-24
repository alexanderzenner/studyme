import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:studyme/models/log/completed_task_log.dart';
import 'package:studyme/models/log/trial_log.dart';
import 'package:studyme/models/measure/measure.dart';

class LogData extends ChangeNotifier {
  static const completedTaskIdsKey = 'completedTasks';

  void addCompletedTaskId(String id) async {
    Box box = await Hive.openBox(completedTaskIdsKey);
    box.add(CompletedTaskLog(taskId: id, dateTime: DateTime.now()));
    notifyListeners();
  }

  Future<List<String>> getCompletedTaskIdsFor(DateTime date) async {
    Box box = await Hive.openBox(completedTaskIdsKey);
    List<CompletedTaskLog> _logs = box.values.toList().cast<CompletedTaskLog>();
    _logs.removeWhere((log) => log.dateTime.difference(date).inDays.abs() > 0);
    return _logs.map((log) => log.taskId).toList();
  }

  Future<List<TrialLog>> getMeasureLogs(Measure measure) async {
    Box box = await Hive.openBox(measure.id);
    return box.values.toList().cast<TrialLog>();
  }

  void checkForDuplicatesAndAdd(List<TrialLog> newLogs, Measure measure) async {
    List<TrialLog> existingLogs = await getMeasureLogs(measure);
    List<String> existingLogIds = existingLogs.map((log) => log.id).toList();
    List<TrialLog> uniqueNewLogs = [];
    newLogs.forEach((log) {
      if (!existingLogIds.contains(log.id)) {
        uniqueNewLogs.add(log);
      }
    });
    this.addMeasureLogs(uniqueNewLogs, measure);
  }

  void addMeasureLogs(List<TrialLog> logs, Measure measure) async {
    await _addLogsFor(measure.id, logs);
    notifyListeners();
  }

  _addLogsFor(String boxname, List<TrialLog> logs) async {
    Box box = await Hive.openBox(boxname);
    logs.forEach((log) {
      box.add(log);
    });
  }
}
