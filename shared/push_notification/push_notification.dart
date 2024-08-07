// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:io';

import 'package:cpsales/app/view/landing/landing_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../app/view/leads/lead_details_screen.dart';
import '../../app/view/quotation/quote_single_screen.dart';
import '../../app/view/tasks/taks_screen.dart';
import '../../app/view/tasks/task_detail_screen.dart';
import '../../core/screen_utils.dart';

ValueNotifier<int> notificationCounterValueNotifer = ValueNotifier(0);

class NotificationServices {
  //initialising firebase message plugin
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //initialising firebase message plugin
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //function to initialise flutter local notification plugin to show notifications for android when app is active
  void initLocalNotifications(RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
      // handle interaction when app is active for android
      handleMessage(message);
    });
  }

  //subscribe topic
  void subscribTopic(String topic) async {
    debugPrint("subscribed");
    await messaging.subscribeToTopic(topic);
  }

//unsubscribetpic
  void unSubscribTopic(String topic) async {
    await messaging.unsubscribeFromTopic(topic);
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      notificationCounterValueNotifer.value++;
      notificationCounterValueNotifer.notifyListeners();

      if (kDebugMode) {
        print("notifications title:${notification!.title}");
        print("notifications body:${notification.body}");
        print('count:${android!.count}');
        print('data:${message.data.toString()}');
      }

      if (Platform.isIOS) {
        forgroundMessage();
      }

      if (Platform.isAndroid) {
        initLocalNotifications(message);
        showNotification(message);
      }
    });
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('user granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('user granted provisional permission');
      }
    } else {
      //appsetting.AppSettings.openNotificationSettings();
      if (kDebugMode) {
        print('user denied permission');
      }
    }
  }

  // function to show visible notification when app is active
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        message.notification!.android!.channelId.toString(),
        message.notification!.android!.channelId.toString(),
        importance: Importance.max,
        showBadge: true,
        playSound: true);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            channel.id.toString(), channel.name.toString(),
            channelDescription: 'your channel description',
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
            ticker: 'ticker',
            sound: channel.sound
            //     sound: RawResourceAndroidNotificationSound('jetsons_doorbell')
            //  icon: largeIconPath
            );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  //function to get device token on which we will send the notifications
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        print('refresh');
      }
    });
  }

  //handle tap on notification when app is in background or terminated
  Future<void> setupInteractMessage() async {
    // when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMessage(initialMessage);
    }

    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(event);
    });
  }

  void handleMessage(RemoteMessage message) {
    notificationCounterValueNotifer.value = 0;
    notificationCounterValueNotifer.notifyListeners();

    if (message.data['type'] == 'quotation') {
      if (message.data['objectId'] != null) {
        Screen.open(QuoteSingleScreen(quoteId: message.data['objectId']));
      } else {
        Screen.open(const LandingScreen(
          currentIndex: 2,
        ));
      }
    } else if (message.data['type'] == 'task') {
      if (message.data['objectId'] != null) {
        Screen.open(TaskDetailScreen(
          taskId: message.data['objectId'],
          slectedType: "",
        ));
      } else {
        Screen.open(const TasksScreen());
      }
    } else if (message.data['type'] == 'lead') {
      if (message.data['objectId'] != null) {
        Screen.open(LeadDetailsScreen(
          leadId: message.data['objectId'],
        ));
      } else {
        Screen.open(const LandingScreen(
          currentIndex: 1,
        ));
      }
    }
  }

  Future forgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
