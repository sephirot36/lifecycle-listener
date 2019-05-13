import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecycle_listener/lifecycle_listener.dart';

void main() {
  const MethodChannel channel = MethodChannel('lifecycle_listener');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await LifecycleListener.platformVersion, '42');
  });
}
