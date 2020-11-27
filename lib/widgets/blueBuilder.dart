import 'package:bluscan/feedback_screens/errorScreen.dart';
import 'package:bluscan/uploadBolt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_blue_beacon/flutter_blue_beacon.dart';
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

Stream<List<Bolt>> periodicBluetoothScanner(BuildContext context) async* {
  final Map<String, Bolt> bolts = Map();
  final FlutterBlueBeacon flutterBlueBeacon = FlutterBlueBeacon.instance;

  while (true) {
    yield* flutterBlueBeacon.scan(timeout: Duration(seconds: 20)).map((event) {
      Beacon beacon = event;

      // compureba condiciones de que se trata de un Perno
      if (beacon is EddystoneUID) {
        bolts[beacon.id] = Bolt(beacon.id,
            medicion: Medicion(
                namespaceIdToMedicion(beacon.namespaceId), DateTime.now()));
      }
      return bolts.values.toList();
    });

    bolts.values.forEach((bolt) {
      //comprueba si hay peligro en algun perno encontrado
      if (bolt.estado == Estado.PELIGRO) {
        Navigator.pushNamed(context, '/alarm');
      }
      // sube cada perno
      uploadBolt(bolt);
    });

    await Future.delayed(Duration(seconds: 40));
  }
}
