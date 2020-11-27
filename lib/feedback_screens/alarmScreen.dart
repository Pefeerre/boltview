import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class AlarmScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    FlutterRingtonePlayer.play(
      android: AndroidSounds.notification,
      ios: IosSounds.glass,
      looping: true, // Android only - API >= 28
      volume: 0.7, // Android only - API >= 28
      asAlarm: true, // Android only - all APIs
    );
    FlutterRingtonePlayer.playAlarm();
    //dangerAlarmNotification();
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
                'se ha detectado un nivel de carga peligroso en un perno cercano',
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
                })
          ],
        ));
  }
}

//   Future dangerAlarmNotification() async {
//     const androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'alarm_notif',
//       'alarm_notif',
//       'Channel 1',
//       playSound: true,
//       sound: RawResourceAndroidNotificationSound('alerta_peligro'),
//       enableVibration: true,
//       priority: Priority.max,
//       importance: Importance.max,
//     );
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);

//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'PELIGRO',
//       'Exceso de carga en un perno cercano',
//       platformChannelSpecifics,
//     );
//   }
