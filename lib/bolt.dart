import 'package:cloud_firestore/cloud_firestore.dart';

enum Estado { SEGURO, PRECAUCION, PELIGRO }

class Bolt {
  String id;
  String name = 'Perno';
  bool fromFirebase;
  Medicion medicion;
  //bool encontradoPorBluetooth;

  Estado get estado {
    if (0 < medicion.medicion && medicion.medicion < 12000) {
      return Estado.SEGURO;
    }
    if (12000 < medicion.medicion && medicion.medicion < 25000) {
      return Estado.PRECAUCION;
    }
    if (25000 < medicion.medicion) {
      return Estado.PELIGRO;
    }
    return Estado.PRECAUCION;
  }

  Stream<Medicion> medicionesFromFirebase() async* {
    yield* FirebaseFirestore.instance
        .collection('pernos')
        .doc(this.id)
        .collection('mediciones')
        .snapshots()
        .map((event) {
      Map<String, dynamic> ultimaMedicion = event.docs[0].data();

      return Medicion(ultimaMedicion['medicion'], ultimaMedicion['fecha']);
    });
  }

  Bolt(this.id, {this.medicion, this.fromFirebase = false}) {
    //pormientras constructor x
    if (fromFirebase) {
      this.medicion = Medicion(0, DateTime.now());
    }
  }
}

class Medicion {
  int medicion;
  DateTime fecha;
  Medicion(this.medicion, this.fecha);
}

int namespaceIdToMedicion(String namespaceId) {
  try {
    return int.parse(namespaceId.substring(2, 6), radix: 16);
  } catch (e) {
    return 0;
  }
}
