import 'package:hive/hive.dart';

part 'trial_log.g.dart';

@HiveType(typeId: 50)
class TrialLog {
  @HiveField(0)
  String loggedItemId;

  @HiveField(1)
  DateTime dateTime;

  @HiveField(2)
  num value;

  TrialLog(this.loggedItemId, this.dateTime, this.value);

  String get id =>
      this.loggedItemId + this.dateTime.toString() + this.value.toString();
}
