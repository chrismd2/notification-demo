//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // we need this for the vibrations
import 'dart:io'; // we need this for the sleep method
import 'package:vibration/vibration.dart'; //different vibrate method

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'dart:isolate';

void printHello() {
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
}

void mainJunk() async {
  printHello();
  print('entered main\n');
  final int helloAlarmID = 0;
  await AndroidAlarmManager.initialize();
  runApp(MyApp());
  await AndroidAlarmManager.periodic(const Duration(seconds: 10), helloAlarmID, printHello);
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vibrate Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VibrateHomepage(),
    );
  }
}

class VibrateHomepage extends StatefulWidget {
  VibrateHomepage({Key key}) : super(key: key);

  @override
  _VibrateHomepageState createState() => _VibrateHomepageState();
}

class _VibrateHomepageState extends State<VibrateHomepage> {

  _Custom(){
      Vibration.vibrate(duration: 1000, amplitude: 255);
      sleep(const Duration(milliseconds: 1000),);
      Vibration.vibrate(duration: 500, amplitude: 100);
      sleep(const Duration(milliseconds: 250),);
      Vibration.cancel();
      sleep(const Duration(milliseconds: 250),);
      Vibration.vibrate(duration: 1000, amplitude: 255);
  }

  Future<int> _TooLong() async{
    await Vibration.vibrate(duration: 100000, amplitude: 255);
    return 1;
  }

  _Stop(){
    Vibration.cancel();
  }


  _PatternVibrate() {
    HapticFeedback.mediumImpact();

    sleep(
      const Duration(milliseconds: 200),
    );

    HapticFeedback.mediumImpact();

    sleep(
      const Duration(milliseconds: 500),
    );

    HapticFeedback.mediumImpact();

    sleep(
      const Duration(milliseconds: 200),
    );
    HapticFeedback.mediumImpact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                child: Text('HapticFeedback.vibrate()'),
                onPressed: () {
                  HapticFeedback.vibrate();
                },
                color: Colors.deepPurple[100],
              ),
            ),
            Expanded(
              child: FlatButton(
                child: Text('HapticFeedback.selectionClick()'),
                onPressed: () {
                  HapticFeedback.selectionClick();
                },
                color: Colors.deepPurple[200],
              ),
            ),
            Expanded(
              child: FlatButton(
                child: Text('Custom - stop'),
                onPressed: () {
                  _Stop();
                },
                color: Colors.deepPurple[300],
              ),
            ),
            Expanded(
              child: FlatButton(
                child: Text('Custom - too long'),
                onPressed: () {
                  _TooLong();
                },
                color: Colors.deepPurple[400],
              ),
            ),
            Expanded(
              child: FlatButton(
                child: Text('Custom - long vibrate'),
                onPressed: () {
                  _Custom();
                  //VibrationEffect.createOneShot(1000, 128)
                },
                color: Colors.deepPurple[500],
              ),
            ),
            Expanded(
              child: FlatButton(
                child: Text('Pattern - heart beat'),
                onPressed: () {
                  _PatternVibrate();
                },
                color: Colors.deepPurple[600],
              ),
            )
          ],
        ),
      ),
    );
  }
}