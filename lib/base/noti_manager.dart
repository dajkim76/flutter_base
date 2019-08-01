import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiManager {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  NotiManager._privateConstructor() {
    _init();
  }

  void _init() {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
    var initializationSettingsAndroid = new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    _flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: null);
  }

  static final NotiManager instance = NotiManager._privateConstructor();

  void createDebugNoti(String title, String message, String payload) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'CHANNEL_FOR_DEBUG', 'Debug', 'Notification for debug',
        playSound: false, importance: Importance.Default, priority: Priority.Default, autoCancel: false);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      message.hashCode,
      title,
      message,
      platformChannelSpecifics,
      payload: payload,
    );
  }
}
