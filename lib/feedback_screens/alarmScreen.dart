import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:vibration/vibration.dart';

class AlarmScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dangerAlarmNotification();
    return Scaffold(
        backgroundColor: Colors.redAccent,
        body: Column(
          children: [
            SizedBox(
              height: 150.0,
            ),
            Text(
              'PELIGRO!!',
              style: TextStyle(color: Colors.white, fontSize: 25.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Se ha detectado un nivel de carga peligroso en un perno cercano',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                  FlutterRingtonePlayer.stop();
                  Vibration.cancel();
                })
          ],
        ));
  }
}

Future dangerAlarmNotification() async {
  FlutterRingtonePlayer.play(
    android: AndroidSounds.ringtone,
    ios: IosSounds.glass,
    looping: true, // Android only - API >= 28
    volume: 0.7, // Android only - API >= 28
    asAlarm: true, // Android only - all APIs
  );
  FlutterRingtonePlayer.playRingtone();
  if (await Vibration.hasVibrator()) {
    Vibration.vibrate(pattern: [500, 1000, 500, 2000, 500, 3000, 500, 500]);
  }
}
