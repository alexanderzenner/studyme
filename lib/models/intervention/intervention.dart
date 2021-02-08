import 'package:hive/hive.dart';
import 'package:studyme/models/intervention/intervention_schedule.dart';
import 'package:uuid/uuid.dart';

import 'no_intervention.dart';

part 'intervention.g.dart';

@HiveType(typeId: 101)
class Intervention {
  static const String interventionType = 'intervention';

  @HiveField(0)
  String type;

  @HiveField(1)
  String id;

  @HiveField(2)
  String name;

  @HiveField(3)
  String description;

  @HiveField(4)
  String letter;

  @HiveField(5)
  InterventionSchedule schedule;

  Intervention({id, type, this.name, this.description, this.letter})
      : this.id = id ?? Uuid().v4(),
        this.type = type ?? interventionType,
        this.schedule = InterventionSchedule();

  Intervention.clone(Intervention intervention)
      : type = intervention.type,
        name = intervention.name,
        description = intervention.description,
        letter = intervention.letter,
        schedule = intervention.schedule != null
            ? intervention.schedule.clone()
            : null;

  clone() {
    switch (this.runtimeType) {
      case NoIntervention:
        return NoIntervention.clone(this);
      default:
        return Intervention.clone(this);
    }
  }
}
