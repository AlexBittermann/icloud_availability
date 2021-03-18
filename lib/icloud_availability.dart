
import 'dart:async';

import 'package:flutter/services.dart';

class IcloudAvailability {
  static const MethodChannel _channel =
      const MethodChannel('icloud_availability');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
