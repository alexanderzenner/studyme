import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:studyme/models/log/log.dart';
import 'package:studyme/models/measure/measure.dart';

class LogData extends ChangeNotifier {
  Future<List<TrialLog>> getLogsFor(Measure measure) async {
    Box box = await Hive.openBox(measure.id);
    return box.values.toList().cast<TrialLog>();
  }

  void addLogsForMeasure(List<TrialLog> logs, Measure measure) async {
    Box box = await Hive.openBox(measure.id);
    logs.forEach((log) {
      box.add(log);
    });

    notifyListeners();
  }

  void checkForDuplicatesAndAdd(List<TrialLog> newLogs, Measure measure) async {
    List<TrialLog> existingLogs = await getLogsFor(measure);
    List<String> existingLogIds = existingLogs.map((log) => log.id).toList();
    List<TrialLog> uniqueNewLogs = [];
    newLogs.forEach((log) {
      if (!existingLogIds.contains(log.id)) {
        uniqueNewLogs.add(log);
      }
    });
    print(uniqueNewLogs);
    this.addLogsForMeasure(uniqueNewLogs, measure);
  }
}
