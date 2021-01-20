import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:uuid/uuid.dart';

import 'choice_measure.dart';
import 'free_measure.dart';

part 'measure.g.dart';

@HiveType(typeId: 0)
class Measure extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String type;
  @HiveField(2)
  String name;
  @HiveField(3)
  String description;

  IconData icon;

  Measure({id, this.type, this.name, this.description})
      : id = id != null ? id : Uuid().v4();

  Measure.clone(Measure measure)
      : id = Uuid().v4(),
        type = measure.type,
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

  dynamic get tickProvider => null;
}
