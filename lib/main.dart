import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'bolt.dart';
import 'package:flutter_blue_beacon/flutter_blue_beacon.dart';

void main() {
  runApp(LaApp());
}

class LaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(home: BoltViewer());
          }
          return MaterialApp(home: Loading());
        });
  }
}

class BoltViewer extends StatefulWidget {
  @override
  _BoltViewerState createState() => _BoltViewerState();
}

class _BoltViewerState extends State<BoltViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Bolt Viewer')),
      body: SingleChildScrollView(
          child: Column(
        children: [BluetoothStreamBuilder(), FirebaseStreamBuilder()],
      )),
    );
  }
}

class FirebaseStreamBuilder extends StatelessWidget {
  const FirebaseStreamBuilder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('pernos').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Algo anda mal'));
          }
          return Column(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              Bolt perno =
                  Bolt(document.data()['id'], document.data()['namespaceId']);
              return BoltCard(perno);
            }).toList(),
          );
        });
  }
}

class BluetoothStreamBuilder extends StatelessWidget {
  final FlutterBlueBeacon flutterBlueBeacon = FlutterBlueBeacon.instance;

  final Map<String, Bolt> bolts = Map();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Beacon>(
        stream: flutterBlueBeacon.scan(timeout: Duration(seconds: 20)),
        builder: (context, snapshot) {
          Beacon beacon = snapshot.data;

          // compureba condiciones de que se trata de un Perno
          if (beacon is EddystoneUID) {
            bolts[beacon.id] = Bolt(beacon.id, beacon.namespaceId);
          }
          return Column(
              children: bolts.values.map((b) => BoltCard(b)).toList());
        });
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
          subtitle: Text('${bolt.id}\n${bolt.medicion}'),
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

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
