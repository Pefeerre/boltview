enum Estado { SEGURO, PRECAUCION, PELIGRO }

class Bolt {
  String id;
  String name = 'Perno';
  String namespaceId;
  DateTime fechaDeActualizacion;
  bool encontradoPorBluetooth;
  int medicion;
  Estado get estado {
    if (0 < medicion && medicion < 12000) {
      return Estado.SEGURO;
    }
    if (12000 < medicion && medicion < 25000) {
      return Estado.PRECAUCION;
    }
    if (25000 < medicion) {
      return Estado.PELIGRO;
    }
    return Estado.PRECAUCION;
  }

  Bolt(this.id, this.namespaceId, {this.encontradoPorBluetooth = false}) {
    if (encontradoPorBluetooth) {
      this.fechaDeActualizacion = DateTime.now();
    }
    try {
      this.medicion = int.parse(this.namespaceId.substring(2, 6), radix: 16);
    } catch (e) {
      medicion = 0;
    }
  }
}
