import 'package:flutter/material.dart';
import 'package:studyme/models/intervention.dart';
import 'package:studyme/models/task/task.dart';

import 'package:studyme/util/time_of_day_extension.dart';

class InterventionTask extends Task {
  Intervention intervention;

  InterventionTask(this.intervention, TimeOfDay time)
      : super(title: intervention.instructions, time: time);

  @override
  String get id => intervention.id + time.combined.toString();
}
