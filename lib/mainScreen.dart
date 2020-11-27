import 'package:bluscan/widgets/blueBuilder.dart';
import 'package:bluscan/widgets/fireBuilder.dart';
import 'package:flutter/material.dart';

class MainScreenBoltList extends StatefulWidget {
  @override
  _MainScreenBoltListState createState() => _MainScreenBoltListState();
}

class _MainScreenBoltListState extends State<MainScreenBoltList> {
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
