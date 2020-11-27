import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'bolt.dart';

StreamController<List<Bolt>> boltsFirebaseCtrl =
    StreamController<List<Bolt>>.broadcast();

void addBoltsFromFirebase() async {
  CollectionReference boltCollection =
      FirebaseFirestore.instance.collection('pernos');

  Map<String, Bolt> bolts = Map<String, Bolt>();

  boltCollection.snapshots().listen((pernos) {
    pernos.docs.forEach((boltDoc) {
      String boltId = boltDoc.data()['id'];
      bolts[boltId] = Bolt(boltId);
      boltsFirebaseCtrl.add(bolts.values.toList());
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
    Medicion ultimaMedicion = Medicion(ultimaMedicionMap['medicion'],
        (ultimaMedicionMap['fecha'] as Timestamp).toDate());
    bolt.medicion = ultimaMedicion;
    return ultimaMedicion;
  });
}
