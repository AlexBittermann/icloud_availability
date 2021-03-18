import 'dart:async';

import 'package:flutter/services.dart';

class ICloudAvailability {
  static const MethodChannel _channel =
      const MethodChannel('icloud_availability');
  static const EventChannel _eventChannel =
      const EventChannel('icloud_availability/event');

  static Future<bool> get available async {
    return await _channel.invokeMethod('isAvailable');
  }

  static Future<Stream<bool>> watchAvailability() async {
    await _channel.invokeMethod('watchAvailability');
    return _eventChannel
        .receiveBroadcastStream()
        .where((event) => event is bool)
        .map((event) => event as bool);
  }
}
