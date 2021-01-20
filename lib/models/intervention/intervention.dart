import 'package:hive/hive.dart';

import 'abstract_intervention.dart';

part 'intervention.g.dart';

@HiveType(typeId: 101)
class Intervention extends AbstractIntervention {
  static const String interventionType = 'real';

  Intervention() : super(interventionType);

  Intervention.clone(Intervention intervention) : super.clone(intervention);
}
