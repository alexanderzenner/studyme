import 'package:hive/hive.dart';
import 'package:studyme/models/log/log.dart';

part 'intervention_log.g.dart';

@HiveType(typeId: 50)
class InterventionLog extends TrialLog {
  static const String logType = 'intervention';

  InterventionLog(loggedItemId, dateTime, value)
      : super(logType, loggedItemId, dateTime, value);
}
