import 'package:flutter/material.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/task/task.dart';

class InterventionTask extends Task {
  Intervention intervention;

  InterventionTask(this.intervention, TimeOfDay time)
      : super(title: intervention.name, body: intervention.name, time: time);
}
