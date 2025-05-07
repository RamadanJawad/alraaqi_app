import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationManager {
  static void displayPrayTimeNotification({
    required String title,
    required String description,
    required int hour,
    required int minute,
    required int id,
  }) {
    DateTime now = DateTime.now();
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'prayTime_channel',
        title: title,
        body: description,
        backgroundColor: Colors.white,
        wakeUpScreen: true,
      ),
      schedule: NotificationCalendar(
        year: now.year,
        month: now.month,
        day: now.day,
        hour: hour,
        minute: minute,
        second: 0,
        millisecond: 0,
        allowWhileIdle: true,
        repeats: true,
      ),
    );
  }
}
