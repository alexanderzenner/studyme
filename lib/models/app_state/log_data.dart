import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:studyme/models/log/log.dart';
import 'package:studyme/models/measure/measure.dart';

class LogState extends ChangeNotifier {
  Future<List<TrialLog>> getLogsFor(Measure measure) async {
    Box box = await Hive.openBox(measure.id);
    return box.values.toList().cast<TrialLog>();
  }

  void addLog(TrialLog log) async {
    Box box = await Hive.openBox(log.loggedItemId);
    box.add(log);
    notifyListeners();
  }
}
