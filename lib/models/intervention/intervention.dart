import 'package:hive/hive.dart';
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

  Intervention({id, type, this.name, this.description})
      : this.id = id ?? Uuid().v4(),
        this.type = type ?? interventionType;

  Intervention.clone(Intervention intervention)
      : type = intervention.type,
        name = intervention.name,
        description = intervention.description;

  clone() {
    switch (this.runtimeType) {
      case NoIntervention:
        return NoIntervention.clone(this);
      default:
        return Intervention.clone(this);
    }
  }
}

class InterventionWithContext {
  final bool isA;
  final Intervention intervention;

  InterventionWithContext({this.isA, this.intervention});
}
