import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shope_ease/main.dart';
import 'package:shope_ease/utils/constants.dart';
import 'package:shope_ease/widgets/shared_preference.dart';


class LocalNotificationData {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialNotification() async {
    await _firebaseMessaging.requestPermission();
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    final fcmToken = await _firebaseMessaging.getToken();
    print("Token: $fcmToken");
    SharedPreference()
        .putStringPreference(PreferenceConstants.fcmToken, fcmToken);
    initPushNotification();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    print(message.notification?.body);

    showBigTextNotification(
        title: message.notification!.title.toString(),
        body: message.notification!.body.toString(),
        flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin);
  }

  Future<void> initPushNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle the message when the app is in the foreground
      handleMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle the message when the user taps the notification and the app is in the background
      handleMessage(message);
    });
  }

  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var iOSPermission = FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();

    var androidPermission = AndroidFlutterLocalNotificationsPlugin();

    await iOSPermission?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );

    await androidPermission.requestPermission();

    var androidInitialize =
        const AndroidInitializationSettings('@drawable/background');

    DarwinInitializationSettings initializationSettingsDarwin =
        const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidInitialize, iOS: initializationSettingsDarwin);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future showBigTextNotification({
    var id = 0,
    required String title,
    required String body,
    var payload,
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "my_trial_notification",
      "channel name",
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(presentSound: false);
    var not = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    try {
      await flutterLocalNotificationsPlugin.show(0, title, body, not);
    } catch (e) {
      print(e);
    }
  }
}
