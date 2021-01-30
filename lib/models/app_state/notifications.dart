import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:studyme/models/reminder.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Notifications {
  static Notifications _instance;
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  Notifications._internal() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _configureLocalTimeZone();
    _instance = this;
  }

  factory Notifications() {
    if (_instance == null) {
      _instance = Notifications._internal();
    }

    return _instance;
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
  }

  Future<void> scheduleNotificationFor(Reminder reminder, int id) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        'Check in on your trial',
        'It\'s time to check in on your trial and to log your data.',
        _nextInstanceOf(reminder.time),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'daily notification channel id',
              'daily notification channel name',
              'daily notification description'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime _nextInstanceOf(TimeOfDay time) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<bool> requestPermission() {
    return _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  showPendingRequests() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await _flutterLocalNotificationsPlugin.pendingNotificationRequests();

    if (pendingNotificationRequests.length > 0) {
      pendingNotificationRequests.forEach((element) {
        print(element.id);
        print(element.title);
      });
    }
  }

  clearAll() async {
    _flutterLocalNotificationsPlugin.cancelAll();
  }
}
