import 'abstract_intervention.dart';

class Intervention extends AbstractIntervention {
  static const String interventionType = 'real';

  Intervention() : super(interventionType);

  Intervention.clone(Intervention intervention) : super.clone(intervention);
}
