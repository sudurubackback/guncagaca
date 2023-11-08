import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:guncagaca/firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> fcmSetting() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'notification',
    'notification',
    description: '알림입니다.',
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // // 아이콘 설정 추가
  // const AndroidInitializationSettings initializationSettingsAndroid =
  // AndroidInitializationSettings('app_icon');
  //
  //
  // final InitializationSettings initializationSettings =
  // InitializationSettings(android: initializationSettingsAndroid);

  // await flutterLocalNotificationsPlugin.initialize(
  //   initializationSettings,
  //   onSelectNotification: (String? payload) async {
  //     // 알림을 클릭했을 때의 동작을 추가할 수 있습니다.
  //   },
  // );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    print('Got a message whilst in the foreground!');
    print('Message data : ${message.data}');

    if (message.notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification?.title,
        notification?.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'main_img', // 아이콘의 리소스 이름
          ),
        ),
      );

      print('Message also contained a notification : ${message.notification}');
    }
  });

  String? firebaseToken = await messaging.getToken();

  print("firebaseToken : ${firebaseToken}");
}
