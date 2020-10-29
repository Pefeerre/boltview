import 'package:flutter/material.dart';

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
    //if(encontradoPorBluetooth){
    this.fechaDeActualizacion = DateTime.now();
    //}
    try {
      this.medicion = int.parse(this.namespaceId.substring(2, 6), radix: 16);
    } catch (e) {
      medicion = 0;
    }
  }
}

class BoltCard extends StatelessWidget {
  final Bolt bolt;
  BoltCard(this.bolt);

  Widget _iconoEstado(Estado estado) {
    switch (estado) {
      case Estado.SEGURO:
        return Icon(
          Icons.check_circle,
          color: Colors.lightGreen,
        );
      case Estado.PRECAUCION:
        return Icon(Icons.warning, color: Colors.yellow);
      case Estado.PELIGRO:
        return Icon(Icons.warning, color: Colors.red);
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: ListTile(
          title: Text(bolt.name),
          subtitle: Text(
              '${bolt.id}\n${bolt.medicion}\nultimavez actualizado: ${fechaLinda(bolt.fechaDeActualizacion)}'),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _iconoEstado(bolt.estado),
              Text(
                bolt.estado.toString().substring(7),
                style: TextStyle(fontSize: 8),
              )
            ],
          ),
        ));
  }
}

String fechaLinda(DateTime fecha) {
  if (DateTime.now().difference(fecha).inDays < 1) {
    return 'Hoy a las ${fecha.toString().substring(11, 16)}';
  }
  return fecha.toString().substring(0, 10);
}
