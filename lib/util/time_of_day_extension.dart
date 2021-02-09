import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  String get readable => DefaultMaterialLocalizations()
      .formatTimeOfDay(this, alwaysUse24HourFormat: true);

  double get combined => hour + minute / 60.0;
}
