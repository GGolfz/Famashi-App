import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class PushNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static void initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    _configureLocalTimeZone();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static void _configureLocalTimeZone() {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Bangkok'));
  }

  static NotificationDetails getNotificationDetails() {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("famashi_notification",
            "famashi_notification", "famashi_notification",
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    return NotificationDetails(android: androidNotificationDetails);
  }

  static tz.TZDateTime _nextInstanceOfTime(int day, int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(Duration(days: 1));
    }
    scheduledDate = scheduledDate.add(Duration(days: day));
    return scheduledDate;
  }

  static Future<void> scheduleNotification(
      int id, String timeType, DateTime time) async {
    NotificationDetails notificationDetails = getNotificationDetails();
    for (var day = 0; day <= 6; day++) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        (day + 1) * 10 + id,
        '$timeType medicine',
        "Don't forget to take your ${timeType.toLowerCase()} medicine",
        _nextInstanceOfTime(day, time.hour, time.minute),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
      );
    }
  }

  static Future<void> clearAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  static Future<void> getPending() async {
    List<PendingNotificationRequest> temp =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    print(temp.length);
  }
}
