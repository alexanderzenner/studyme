import 'package:hive/hive.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/intervention/no_intervention.dart';

part 'abstract_intervention.g.dart';

@HiveType(typeId: 100)
class AbstractIntervention extends HiveObject {
  @HiveField(0)
  String type;

  @HiveField(1)
  String id;

  @HiveField(2)
  String name;

  @HiveField(3)
  String description;

  AbstractIntervention(this.type);

  AbstractIntervention.clone(AbstractIntervention intervention)
      : type = intervention.type,
        name = intervention.name,
        description = intervention.description;

  clone() {
    switch (this.runtimeType) {
      case Intervention:
        return Intervention.clone(this);
      case NoIntervention:
        return NoIntervention.clone(this);
    }
  }
}
