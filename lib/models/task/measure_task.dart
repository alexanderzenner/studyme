import 'package:flutter/material.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/task/task.dart';

import 'package:studyme/util/time_of_day_extension.dart';

class MeasureTask extends Task {
  Measure measure;

  MeasureTask(this.measure, TimeOfDay time)
      : super(
            title: "Log your ${measure.name}", body: measure.name, time: time);

  @override
  String get id => measure.id + time.combined.toString();
}
