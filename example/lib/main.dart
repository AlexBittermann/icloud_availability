import 'dart:async';

import 'package:flutter/material.dart';
import 'package:icloud_availability/icloud_availability.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
                onPressed: () => ICloudAvailability.available,
              ),
              TextButton(
                child: Text('Watch Availability'),
                onPressed: testWatchAvailability,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> testWatchAvailability() async {
    final fileListStream = await ICloudAvailability.watchAvailability();
    final fileListSubscription = fileListStream.listen((available) {
      print('--- Watch Available --- value: $available');
    });

    Future.delayed(Duration(seconds: 10), () {
      fileListSubscription.cancel();
      print('--- Watch Available --- canceled');
    });
  }
}
