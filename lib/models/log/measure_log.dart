import 'package:studyme/models/log/log.dart';

class MeasureLog extends TrialLog {
  static const String logType = 'measure';

  MeasureLog(loggedItemId, dateTime, value)
      : super(logType, loggedItemId, dateTime, value);
}
