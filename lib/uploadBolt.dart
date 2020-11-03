import 'package:cloud_firestore/cloud_firestore.dart';
import 'bolt.dart';

uploadBolt(Bolt perno) async {
  CollectionReference pernos = FirebaseFirestore.instance.collection('pernos');
  pernos.doc(perno.id).set({'id': perno.id, 'nombre': 'Perno'});
  pernos
      .doc(perno.id)
      .collection('mediciones')
      .doc(perno.medicion.fecha.toString().substring(0, 16))
      .set(
          {'medicion': perno.medicion.medicion, 'fecha': perno.medicion.fecha});
}
