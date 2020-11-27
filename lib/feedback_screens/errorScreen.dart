import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ErrorScreen extends StatelessWidget {
  final dynamic error;
  ErrorScreen(this.error);
  @override
  Widget build(BuildContext context) {
    if (error is PlatformException) {
      //si el error fuese por que no hay conexion a firebase
      return Container();
    }
    return Container(
        color: Colors.red,
        child: Center(
            child: Text(
          'Algo anda mal: \n ${error.toString()}',
          style: TextStyle(color: Colors.white),
        )));
    ;
  }
}
