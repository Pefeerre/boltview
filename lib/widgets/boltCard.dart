import 'package:bluscan/firebaseBoltStream.dart';
import 'package:flutter/material.dart';
import '../bolt.dart';

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

String fechaLinda(DateTime fecha) {
  if (DateTime.now().difference(fecha).inDays < 1) {
    return 'Hoy a las ${fecha.toString().substring(11, 16)}';
  }
  return fecha.toString().substring(0, 10);
}

class BlueBoltCard extends StatelessWidget {
  final Bolt bolt;
  BlueBoltCard(this.bolt);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: ListTile(
          title: Text(bolt.name),
          subtitle: Text(
              '${bolt.id}\n${bolt.medicion.medicion}\nultimavez actualizado: ${fechaLinda(bolt.medicion.fecha)}'),
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

class FireBoltCard extends StatelessWidget {
  final Bolt bolt;
  FireBoltCard(this.bolt);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Medicion>(
        stream: ultimaMedicionFromFirebase(bolt),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Card(
              child: ListTile(
                title: Text(bolt.name),
                trailing: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 8.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
          if (bolt.estado == Estado.PELIGRO) {
            Navigator.pushNamed(context, '/alarm');
          }
          return Card(
              color: Colors.white,
              child: ListTile(
                title: Text(bolt.name),
                subtitle: Text(
                    'ultimavez actualizado: ${fechaLinda(bolt.medicion.fecha)}'),
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
        });
  }
}
