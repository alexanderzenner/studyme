import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:studyme/models/log/trial_log.dart';
import 'package:studyme/models/measure/measure.dart';

class LogData extends ChangeNotifier {
  static const adherenceKey = 'adherence';

  Future<List<TrialLog>> getAdherenceLogs() async {
    return _getLogsFor(adherenceKey);
  }

  Future<List<TrialLog>> getMeasureLogs(Measure measure) async {
    return _getLogsFor(measure.id);
  }

  Future<List<TrialLog>> _getLogsFor(String boxname) async {
    Box box = await Hive.openBox(boxname);
    return box.values.toList().cast<TrialLog>();
  }

  void addAdherenceLog(TrialLog log) async {
    _addLogsFor(adherenceKey, [log]);
    notifyListeners();
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
