import 'package:bluscan/feedback_screens/loadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../bolt.dart';
import 'boltCard.dart';
import '../feedback_screens/errorScreen.dart';
import '../firebaseBoltStream.dart';

class FirebaseBaseBolts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            addBoltsFromFirebase();
            return FirebaseStreamBuilder();
          } else {
            return Container(
                child: Center(child: Text('inicializando base de datos..')));
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
          if (!snapshot.hasData) {
            return Loading();
          }
          if (snapshot.hasError) {
            return ErrorScreen(snapshot.error);
          }

          return Column(
            children: snapshot.data.map((perno) {
              return FireBoltCard(perno);
            }).toList(),
          );
        });
  }
}
