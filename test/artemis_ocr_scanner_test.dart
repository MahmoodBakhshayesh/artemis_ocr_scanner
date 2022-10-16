// import 'package:flutter_test/flutter_test.dart';
// import 'package:artemis_ocr_scanner/artemis_ocr_scanner.dart';
// import 'package:artemis_ocr_scanner/artemis_ocr_scanner_platform_interface.dart';
// import 'package:artemis_ocr_scanner/artemis_ocr_scanner_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockArtemisOcrScannerPlatform
//     with MockPlatformInterfaceMixin
//     implements ArtemisOcrScannerPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final ArtemisOcrScannerPlatform initialPlatform = ArtemisOcrScannerPlatform.instance;
//
//   test('$MethodChannelArtemisOcrScanner is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelArtemisOcrScanner>());
//   });
//
//   test('getPlatformVersion', () async {
//     ArtemisOcrScanner artemisOcrScannerPlugin = ArtemisOcrScanner();
//     MockArtemisOcrScannerPlatform fakePlatform = MockArtemisOcrScannerPlatform();
//     ArtemisOcrScannerPlatform.instance = fakePlatform;
//
//     expect(await artemisOcrScannerPlugin.getPlatformVersion(), '42');
//   });
// }
