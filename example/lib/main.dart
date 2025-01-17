import 'dart:async';

import 'package:flutter/material.dart';
import 'package:icloud_availability/icloud_availability.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription? subscription;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('icloud_availability plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              TextButton(
                child: Text('Check Availability'),
                onPressed: () async => print(
                    '--- Check Availability --- value: ${await ICloudAvailability.available}'),
              ),
              TextButton(
                child: Text('Watch Availability'),
                onPressed: testWatchAvailability,
              ),
              TextButton(
                child: Text('Cancel Watch Availability'),
                onPressed: cancelWatchAvailability,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> testWatchAvailability() async {
    print('--- Watch Availability --- start');
    final stream = await ICloudAvailability.watchAvailability();
    subscription = stream.listen((available) {
      print('--- Watch Availability --- value: $available');
    });
  }

  cancelWatchAvailability() {
    subscription?.cancel();
    print('--- Watch Availability --- canceled');
  }
}
