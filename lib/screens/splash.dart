import 'dart:async';
import 'dart:io';
import 'package:congobonmarche/page_routes/routes.dart';
import 'package:congobonmarche/utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SplashScreen> {
  //timer set in splash
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Utils().requestingPermissionForIOS();
    Utils().initfirebasesetting();
    // FirebaseMessaging.onMessage.listen(
    //   (message) {
    //     print(message);
    //     if (message.data.isNotEmpty) {
    //       Utils().showNotification(message);
    //     }
    //   },
    // );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("remote");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        Utils().showNotification(message);
      }
      if (Platform.isIOS) {
        if (notification != null) {
          Utils().flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                  // android: AndroidNotificationDetails(
                  //   channel.id,
                  //   channel.name,
                  //   channelDescript
                  //ion: channel.description,
                  //   color: Colors.blue,
                  //   playSound: true,
                  //   icon: '@mipmap/ic_launcher',
                  // ),
                  iOS: DarwinNotificationDetails()));
        }
      }
    });

    startTimer();
    godo();
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;

    //   if (notification != null && android != null) {
    //     flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         notification.title,
    //         notification.body,
    //         NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             channel.id,
    //             channel.name,
    //             channelDescription: channel.description,
    //             color: Colors.blue,
    //             playSound: true,
    //             icon: '@mipmap/ic_launcher',
    //           ),
    //         ));
    //   }
    //   if (Platform.isIOS) {
    //     if (notification != null) {
    //       flutterLocalNotificationsPlugin.show(
    //           notification.hashCode,
    //           notification.title,
    //           notification.body,
    //           NotificationDetails(
    //               // android: AndroidNotificationDetails(
    //               //   channel.id,
    //               //   channel.name,
    //               //   channelDescription: channel.description,
    //               //   color: Colors.blue,
    //               //   playSound: true,
    //               //   icon: '@mipmap/ic_launcher',
    //               // ),
    //               iOS: IOSNotificationDetails()));
    //     }
    //   }
    // });

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('A new onMessageOpenedApp event was published!');
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     showDialog(
    //         context: context,
    //         builder: (_) {
    //           return AlertDialog(
    //             title: Text(notification.title!),
    //             content: SingleChildScrollView(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [Text(notification.body!)],
    //               ),
    //             ),
    //           );
    //         });
    //   }
    // });
  }

  startTimer() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, homePageRoute);
  }

  void godo() {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    // final DarwinNotificationDetails initializationSettingsIOS =
    //     DarwinNotificationDetails(
    //   requestSoundPermission: false,
    //   requestBadgePermission: false,
    //   requestAlertPermission: false,
    //   onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    // );
    //  final DarwinInitializationSettings initializationSettingsIOS =
    //     DarwinInitializationSettings(
    //   requestAlertPermission: false,
    //   requestBadgePermission: false,
    //   requestSoundPermission: false,
    //   onDidReceiveLocalNotification:
    //       (int id, String? title, String? body, String? payload) async {
    //     didReceiveLocalNotificationSubject.add(
    //       ReceivedNotification(
    //         id: id,
    //         title: title,
    //         body: body,
    //         payload: payload,
    //       ),
    //     );
    //   },
    // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    //   notificationCategories: darwinNotificationCategories,
    // );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            // iOS: initializationSettingsIOS,
            macOS: null);
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title!),
        content: Text(body!),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              // Navigator.of(context, rootNavigator: true).pop();
              // await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => SecondScreen(payload),
              //   ),
              // );
            },
          )
        ],
      ),
    );
  }

  homePageRoute() {
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.homeScreen, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: const Color(0xffd43a40),
            //color: colorPrimary,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/images/splash.png",
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
