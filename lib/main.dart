import 'package:flutter/material.dart';
import 'feedback_screens/alarmScreen.dart';
import 'mainScreen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BoltViewer());
}

class BoltViewer extends StatefulWidget {
  @override
  _BoltViewerState createState() => _BoltViewerState();
}

class _BoltViewerState extends State<BoltViewer> {
  @override
  void initState() {
    super.initState();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    print(title + body + payload);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/': (context) => MainScreenBoltList(),
      '/alarm': (context) => AlarmScreen(),
    });
  }
}
