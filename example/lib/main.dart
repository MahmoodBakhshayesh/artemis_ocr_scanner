// import 'package:artemis_barcode_scanner/artemis_barcode_scanner_view.dart';
// import 'package:artemis_barcode_scanner/artemis_barcode_scanner_view.dart';
import 'package:artemis_ocr_scanner/artemis_ocr_scanner_platform_interface.dart';
import 'package:artemis_ocr_scanner/artemis_ocr_scanner_view.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:artemis_ocr_scanner/artemis_ocr_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _artemisOcrScannerPlugin = ArtemisOcrScanner();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      // platformVersion =
      //     await _artemisOcrScannerPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = "1";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body:Column(children: [Expanded(child:
        ArtemisOcrScannerView
        (
          // mode: UsageMode.camera,
          // onOcrRead: (data){
          //   print(data.text);
          // },
        )
        )],),
      ),
    );
  }
}
