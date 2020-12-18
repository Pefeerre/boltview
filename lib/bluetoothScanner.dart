import 'package:bluscan/uploadBolt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_beacon/flutter_blue_beacon.dart';
import 'firebaseBoltStream.dart';

import 'bolt.dart';

Stream<List<Bolt>> periodicBluetoothScanner(BuildContext context) async* {
  final Map<String, Bolt> blueBolts = Map();
  final FlutterBlueBeacon flutterBlueBeacon = FlutterBlueBeacon.instance;

  while (true) {
    yield* flutterBlueBeacon.scan(timeout: Duration(seconds: 20)).map((event) {
      Beacon beacon = event;

      // compureba condiciones de que se trata de un Perno
      if (beacon is EddystoneUID) {
        blueBolts[beacon.id] = Bolt(
            beacon.id,
            (blueBolts[beacon.id] != null)
                ? blueBolts[beacon.id].name
                : 'Perno',
            medicion: Medicion(namespaceIdToMedicion(beacon.namespaceId),
                DateTime.now(), namespaceIdToBateria(beacon.namespaceId)));
      }
      if (fireBolts[beacon.id] != null) {
        blueBolts[beacon.id].name = fireBolts[beacon.id].name;
      }
      return blueBolts.values.toList();
    });

    blueBolts.values.forEach((bolt) {
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
