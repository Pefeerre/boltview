import 'package:flutter/material.dart';
import 'feedback_screens/alarmScreen.dart';
import 'mainScreen.dart';

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
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/': (context) => MainScreenBoltList(),
      '/alarm': (context) => AlarmScreen(),
    });
  }
}
