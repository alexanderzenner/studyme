import 'package:studyme/models/log/log.dart';

class MeasureLog extends TrialLog {
  static const String logType = 'measure';

  MeasureLog(loggedItemId, value) : super(logType, loggedItemId, value);
}
