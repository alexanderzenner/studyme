import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:studyme/models/log/log.dart';

class LogState extends ChangeNotifier {
  final Box box;
  List<TrialLog> _logs;

  List<TrialLog> getLogs() {
    return _logs;
  }

  LogState({@required this.box}) {
    initBox();
  }

  initBox() {
    print(box.values.toList());
    _logs = [];
  }

  void addLog(TrialLog log) {
    _logs.add(log);
    box.add(1);
    notifyListeners();
  }
}
