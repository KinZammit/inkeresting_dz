import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _plugin.initialize(settings);
  }

  static Future<void> showPinnedNotification(String title) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'pin_channel',
        'Pin Notifications',
        channelDescription: 'Notifications when a tattoo is pinned',
        importance: Importance.high,
        priority: Priority.high,
      ),
    );

    await _plugin.show(
      0,
      'Pinned to your board!',
      '$title has been saved to My Board.',
      details,
    );
  }
}