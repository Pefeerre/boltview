import 'package:bluscan/feedback_screens/errorScreen.dart';
import 'package:flutter/material.dart';
import '../bluetoothScanner.dart';
import '../bolt.dart';
import 'boltCard.dart';

class BluetoothStreamBuilder extends StatelessWidget {
  //final FlutterBlue _flutterBlue = FlutterBlue.instance;

  // StreamSubscription _stateSubscription;
  //BluetoothState state = BluetoothState.unknown;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Bolt>>(
        stream: periodicBluetoothScanner(context),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorScreen(snapshot.error);
          }
          if (!snapshot.hasData) {
            return Container(
              child: Text('No hay pernos encontrados por bluetooth'),
            );
          }
          return Column(
              children: snapshot.data.map((b) => BlueBoltCard(b)).toList());
        });
  }
}
