import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:studyme/models/log/log.dart';
import 'package:studyme/models/measure/free_measure.dart';

class LogState extends ChangeNotifier {
  List<TrialLog> _logs;

  List<TrialLog> getLogs() {
    return _logs;
  }

  void addLog(TrialLog log) {
    _logs.add(log);
    notifyListeners();
  }
}
