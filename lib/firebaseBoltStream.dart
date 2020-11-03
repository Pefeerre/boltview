import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'bolt.dart';

StreamController<List<Bolt>> boltsFirebaseCtrl =
    StreamController<List<Bolt>>.broadcast();

void addBoltsFromFirebase() {
  CollectionReference boltCollection =
      FirebaseFirestore.instance.collection('pernos');

  Map<String, Bolt> bolts = Map<String, Bolt>();

  boltCollection.snapshots().listen((pernos) {
    pernos.docs.forEach((e) {
      String idPerno = e.data()['id'];
      CollectionReference mediciones =
          boltCollection.doc(idPerno).collection('mediciones');
      mediciones.snapshots().listen((event) {
        Map<String, dynamic> ultimaMedicion =
            event.docs[event.docs.length - 1].data();
        bolts[idPerno] = Bolt(idPerno,
            medicion: Medicion(ultimaMedicion['medicion'],
                (ultimaMedicion['fecha'] as Timestamp).toDate()));
        boltsFirebaseCtrl.add(bolts.values.toList());
      });
    });
  });
}
