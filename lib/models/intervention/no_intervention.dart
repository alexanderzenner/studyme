import 'package:hive/hive.dart';
import 'package:studyme/models/intervention/abstract_intervention.dart';

part 'no_intervention.g.dart';

@HiveType(typeId: 102)
class NoIntervention extends AbstractIntervention {
  static const String interventionType = 'null';

  final name = 'No Intervention';
  final description = 'TBD';

  NoIntervention() : super(interventionType);

  NoIntervention.clone(NoIntervention intervention) : super.clone(intervention);
}
