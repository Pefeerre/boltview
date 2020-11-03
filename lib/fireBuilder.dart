import 'package:bluscan/loadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'bolt.dart';
import 'boltCard.dart';
import 'errorScreen.dart';
import 'firebaseBoltStream.dart';

class FirebaseBaseBolts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FirebaseStreamBuilder();
          } else {
            return Container();
          }
        });
  }
}

class FirebaseStreamBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Bolt>>(
        stream: boltsFirebaseCtrl.stream,
        builder: (context, snapshot) {
          addBoltsFromFirebase();
          if (!snapshot.hasData) {
            return Loading();
          }
          if (snapshot.hasError) {
            return ErrorScreen(snapshot.error);
          }
          return Column(
            children: snapshot.data.map((perno) => BoltCard(perno)).toList(),
          );
        });
  }
}
