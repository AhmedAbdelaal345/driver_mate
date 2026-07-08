import 'dart:async';
import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tzlocation;

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotifications =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> stream = StreamController();
  static void onTap(NotificationResponse details) {
    log(details.id.toString());
    log(details.payload.toString());
    stream.add(details);
  }

  static Future<void> initialize() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );
    await requestPermission(); // 👈 أهم سطر

    await flutterLocalNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );

    // Automatically schedule the daily 9:00 AM notification
    await dailysechudleNotificaction();
  }

  static Future<void> requestPermission() async {
    /// Android 13+
    await flutterLocalNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    /// iOS
    await flutterLocalNotifications
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  static Future<void> basicNotification({
    required String notificationId,
    required int id,
    required String title,
    required String body,
  }) async {
    NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        "basic_channel",
        "basic channel",
        channelDescription: "basic notification",
        importance: Importance.high,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound("splash"),
      ),
    );
    await flutterLocalNotifications.show(
      id,
      title,
      body,
      notificationDetails,
      payload: "payLoaded Data",
    );
  }

  static Future<void> repeatedNotification() async {
    NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        "id : 2",
        "repeated channel",
        channelDescription: "repeated notification",
        importance: Importance.high,
        priority: Priority.high,
      ),
    );
    await flutterLocalNotifications.periodicallyShow(
      1,
      "Repeated Notification",
      "body",
      RepeatInterval.everyMinute,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      payload: "payLoaded Data",
    );
  }

  static Future<void> cancelNotification(int id) async {
    flutterLocalNotifications.cancel(id);
  }

  static Future<void> dailysechudleNotificaction() async {
    tz.initializeTimeZones();
    final TimezoneInfo currentTimeZone =
        await FlutterTimezone.getLocalTimezone();

    tzlocation.setLocalLocation(
      tzlocation.getLocation(currentTimeZone.identifier),
    );
    var currentTime = tzlocation.TZDateTime.now(tzlocation.local);
    var scheduledTime = tzlocation.TZDateTime(
      tzlocation.local,
      currentTime.year,
      currentTime.month,
      currentTime.day,
      9, // Hour: 9 AM
      0, // Minute: 0
    );
    if (scheduledTime.isBefore(currentTime)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }
    NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        "id : 4",
        "daily scheduled channel",
        channelDescription: "scheduled notification",
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(subtitle: "daily scheduled notification"),
    );
    await flutterLocalNotifications.zonedSchedule(
      3,
      "Good Morning! 🚗",
      "Check your vehicle's health check status today to keep it running smoothly.",
      scheduledTime,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents:
          DateTimeComponents.time, // repeats daily at 9:00 AM
    );
  }

  static Future<void> cancelAllNotifications() async {
    await flutterLocalNotifications.cancelAll();
  }

  //  Todo: add the notifcation get every day in 9 clock in the morning
}
