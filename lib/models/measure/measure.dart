import 'package:flutter/cupertino.dart';
import 'package:studyme/models/measure/scale_measure.dart';

import 'choice_measure.dart';
import 'free_measure.dart';

abstract class Measure {
  String id;
  String type;
  String name;
  String description;
  IconData icon;

  Measure(this.type);

  Measure.clone(Measure measure)
      : type = measure.type,
        name = measure.name,
        description = measure.description;

  clone() {
    switch (this.runtimeType) {
      case FreeMeasure:
        return FreeMeasure.clone(this);
      case ChoiceMeasure:
        return ChoiceMeasure.clone(this);
      case ScaleMeasure:
        return ScaleMeasure.clone(this);
    }
  }
}
