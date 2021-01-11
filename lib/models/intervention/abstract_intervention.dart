import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/intervention/null_intervention.dart';

abstract class AbstractIntervention {
  String type;
  String id;
  String name;
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
      case NullIntervention:
        return NullIntervention.clone(this);
    }
  }
}
