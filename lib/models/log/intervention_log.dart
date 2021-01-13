import 'package:studyme/models/log/log.dart';

class InterventionLog extends TrialLog {
  static const String logType = 'intervention';

  InterventionLog(loggedItemId, value) : super(logType, loggedItemId, value);
}
