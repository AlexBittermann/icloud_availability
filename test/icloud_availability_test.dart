import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icloud_availability/icloud_availability.dart';

void main() {
  const MethodChannel channel = MethodChannel('icloud_availability');
  const MethodChannel eventChannel = MethodChannel('icloud_availability/event');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return true;
    });
    eventChannel.setMockMethodCallHandler((MethodCall methodCall) async {
      ServicesBinding.instance!.defaultBinaryMessenger.handlePlatformMessage(
          "icloud_availability/event",
          const StandardMethodCodec().encodeSuccessEnvelope(true),
          (ByteData? data) {});
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
    eventChannel.setMethodCallHandler(null);
  });

  test('available', () async {
    expect(await ICloudAvailability.available, true);
  });

  test('watchAvailability', () async {
    var stream = await ICloudAvailability.watchAvailability();
    expect(await stream.first, true);
  });
}
