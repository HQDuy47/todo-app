import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class Noti {
  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var iOSInitialize = const IOSInitializationSettings();
    var initializationsSettings = InitializationSettings(
      android: androidInitialize,
      iOS: iOSInitialize,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  static Future<void> createNotificationChannel(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'you_can_name_it_whatever1',
      'channel_name',
      importance: Importance.max,
      playSound: true,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannel(channel);
  }

  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    required FlutterLocalNotificationsPlugin fln,
  }) async {
    DateTime notificationDateTime =
        scheduledDate.subtract(const Duration(minutes: 10));

    await fln.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(notificationDateTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'you_can_name_it_whatever1',
          'channel_name',
          playSound: true,
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: IOSNotificationDetails(),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
