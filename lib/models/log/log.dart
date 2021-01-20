import 'package:hive/hive.dart';

abstract class TrialLog {
  @HiveField(0)
  String type;

  @HiveField(1)
  String loggedItemId;

  @HiveField(2)
  DateTime dateTime;

  @HiveField(3)
  double value;

  TrialLog(this.type, this.loggedItemId, this.dateTime, this.value);
}
