import 'package:studyme/models/intervention/abstract_intervention.dart';

class NullIntervention extends AbstractIntervention {
  static const String interventionType = 'null';

  final name = 'No Intervention';
  final description = 'TBD';

  NullIntervention() : super(interventionType);

  NullIntervention.clone(NullIntervention intervention)
      : super.clone(intervention);
}
