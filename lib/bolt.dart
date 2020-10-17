enum Estado { SEGURO, PRECAUCION, PELIGRO }

class Bolt {
  String id;
  String name = 'Perno';
  String namespaceId;
  int medicion;
  Estado get estado {
    if (0 < medicion && medicion < 12000) {
      return Estado.SEGURO;
    }
    if (12000 < medicion && medicion < 15000) {
      return Estado.PRECAUCION;
    }
    if (15000 < medicion) {
      return Estado.PELIGRO;
    }
    return Estado.PRECAUCION;
  }

  Bolt(this.id, this.namespaceId) {
    try {
      this.medicion = int.parse(this.namespaceId.substring(2, 5), radix: 16);
    } catch (e) {
      medicion = 0;
      name = e.toString();
    }
  }
}
