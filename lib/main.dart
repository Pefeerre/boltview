import 'package:flutter/material.dart';
import 'blueBuilder.dart';
import 'fireBolts.dart';

void main() {
  runApp(LaApp());
  //funcion de autoguardado gatillada x stream de conexion con frbs
}

class LaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: BoltViewer());
  }
}

class BoltViewer extends StatefulWidget {
  @override
  _BoltViewerState createState() => _BoltViewerState();
}

class _BoltViewerState extends State<BoltViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Bolt Viewer'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [BluetoothStreamBuilder(), FirebaseBaseBolts()],
      )),
    );
  }
}
