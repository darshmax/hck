

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi {
  static final notifications = FlutterLocalNotificationsPlugin();

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        'channel description',
        importance: Importance.max,
      ),

    );
  }

}