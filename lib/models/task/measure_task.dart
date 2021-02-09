import 'package:flutter/material.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/task/task.dart';

class MeasureTask extends Task {
  Measure measure;

  MeasureTask(this.measure, TimeOfDay time)
      : super(
            title: "Log your ${measure.name}", body: measure.name, time: time);
}
