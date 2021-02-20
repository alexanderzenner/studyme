import 'package:hive/hive.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/app_state/log_data.dart';
import 'package:studyme/models/trial.dart';

import 'notifications.dart';

void deleteLogs(Trial trial) {
  Hive.deleteBoxFromDisk(LogData.completedTaskIdsKey);
  trial.measures.forEach((element) {
    Hive.deleteBoxFromDisk(element.id);
  });
}

void debugCancelAllNotifications() {
  Notifications().clearAll();
  Hive.deleteBoxFromDisk(AppData.lastDateWithScheduledNotificationsKey);
  Hive.deleteBoxFromDisk(AppData.notificationIdCounterKey);
}
