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

  Future<void> scheduleNotificationFor(
      DateTime date, Reminder reminder, int id) async {
    tz.TZDateTime scheduledTime = _getScheduledTime(date, reminder.time);
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    if (!scheduledTime.isBefore(now)) {
      print(scheduledTime);
      await _flutterLocalNotificationsPlugin.zonedSchedule(
          0,
          'scheduled title',
          'scheduled body',
          tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
          const NotificationDetails(
              android: AndroidNotificationDetails('your channel id',
                  'your channel name', 'your channel description')),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

  tz.TZDateTime _getScheduledTime(DateTime date, TimeOfDay time) {
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, date.year, date.month, date.day, time.hour, time.minute);
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

  debugShowPendingRequests() async {
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
