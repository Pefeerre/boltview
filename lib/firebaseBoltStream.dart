import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'bolt.dart';

StreamController<List<Bolt>> boltsFirebaseCtrl =
    StreamController<List<Bolt>>.broadcast();

Map<String, Bolt> fireBolts = Map<String, Bolt>();

void addBoltsFromFirebase() async {
  CollectionReference boltCollection =
      FirebaseFirestore.instance.collection('pernos');

  Map<String, Bolt> bolts = Map<String, Bolt>();

  boltCollection.snapshots().listen((pernos) {
    pernos.docs.forEach((boltDoc) {
      String boltId = boltDoc.data()['id'];
      String boltName = boltDoc.data()['nombre'];
      bolts[boltId] = Bolt(boltId, boltName);
      boltsFirebaseCtrl.add(bolts.values.toList());
      fireBolts = bolts;
    });
  });
}

Stream<Medicion> ultimaMedicionFromFirebase(Bolt bolt) async* {
  yield* FirebaseFirestore.instance
      .collection('pernos')
      .doc(bolt.id)
      .collection('mediciones')
      .orderBy('fecha', descending: true)
      .limit(1)
      .snapshots()
      .map((event) {
    Map<String, dynamic> ultimaMedicionMap = event.docs[0].data();
    Medicion ultimaMedicion = Medicion(
        ultimaMedicionMap['medicion'],
        (ultimaMedicionMap['fecha'] as Timestamp).toDate(),
        ultimaMedicionMap['bateria']);
    bolt.medicion = ultimaMedicion;
    return ultimaMedicion;
  });
}
