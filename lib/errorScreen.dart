import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final Error error;
  ErrorScreen(this.error);
  @override
  Widget build(BuildContext context) {
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
