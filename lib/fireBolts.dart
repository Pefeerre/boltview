import 'package:bluscan/loadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'bolt.dart';
import 'errorScreen.dart';

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
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('pernos').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          }
          if (snapshot.hasError) {
            return ErrorScreen(snapshot.error);
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
