import 'package:flutter/cupertino.dart';

enum Estado { SEGURO, PRECAUCION, PELIGRO }

class Bolt {
  String id;
  String name = 'Perno';
  Medicion medicion;

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

  Bolt(this.id, this.name, {this.medicion});
}

class Medicion {
  int medicion;
  DateTime fecha;
  int bateria;
  Medicion(this.medicion, this.fecha, this.bateria);
}

int namespaceIdToMedicion(String namespaceId) {
  try {
    return int.parse(namespaceId.substring(0, 8), radix: 16);
  } catch (e) {
    debugPrint(e.toString());
    return 0;
  }
}

int namespaceIdToBateria(String namespaceId) {
  double porcentajedouble =
      int.parse(namespaceId.substring(11, 20), radix: 16) / 10995116277.75;
  return porcentajedouble.round();
}
