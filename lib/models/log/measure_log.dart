import 'package:hive/hive.dart';
import 'package:studyme/models/log/log.dart';

part 'measure_log.g.dart';

@HiveType(typeId: 51)
class MeasureLog extends TrialLog {
  static const String logType = 'measure';

  MeasureLog(loggedItemId, dateTime, value)
      : super(logType, loggedItemId, dateTime, value);
}
