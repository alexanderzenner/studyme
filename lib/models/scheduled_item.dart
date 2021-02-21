import 'package:hive/hive.dart';
import 'package:studyme/models/schedule.dart';

class ScheduledItem {
  @HiveField(5)
  Schedule schedule;

  ScheduledItem({Schedule schedule}) : this.schedule = schedule ?? Schedule();

  ScheduledItem.clone(ScheduledItem scheduledItem)
      : schedule = scheduledItem.schedule != null
            ? scheduledItem.schedule.clone()
            : null;
}
