import 'package:hive/hive.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/schedule.dart';
import 'package:studyme/models/task/task.dart';

part 'no_intervention.g.dart';

@HiveType(typeId: 102)
class NoIntervention extends Intervention {
  static const String interventionType = 'no_intervention';

  final name = 'No Intervention';
  final description = 'TBD';

  NoIntervention() : super(type: interventionType);

  @override
  final Schedule schedule = null;

  @override
  List<Task> getTasksFor(daysSinceBeginningOfTimeRange) {
    return [];
  }

  NoIntervention.clone(NoIntervention intervention) : super.clone(intervention);
}
