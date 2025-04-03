import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final Client client = Client()
      .setEndpoint('https://cloud.appwrite.io/v1') // Replace
      .setProject('679780d900000280dfd0'); // Replace
  late final Realtime realtime;
  late final Databases databases;
  final String databaseId = '6797c150000fd8bfe40c'; // Replace
  final String collectionId = '67a0e4c0002f07688c3c'; // Replace

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  NotificationService() {
    realtime = Realtime(client);
    databases = Databases(client);
    _initializeLocalNotifications();
    subscribeToDocuments();
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('notif_icon'); // Replace
    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void subscribeToDocuments() {
    final subscription = realtime.subscribe([
      'databases.$databaseId.collections.$collectionId.documents',
    ]);

    subscription.stream.listen((response) {
      print("Realtime Message Received: $response");
      if (response.events.contains(
          'databases.*.collections.*.documents.*.create')) {
        final document = response.payload;
        showNotification('New Event Created', document['title']);
      }
    });
  }

  Future<void> showNotification(String? title, String? body) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'news_events',
      'News Event',
      channelDescription: 'An Event was created in the app',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails);
  }
}