import 'dart:convert';
import 'dart:developer';

import 'package:artemis_ocr_scanner/artemis_ocr_scanner_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'artemis_ocr_scanner_platform_interface.dart';

class ArtemisOcrScannerView extends StatefulWidget {
  final void Function(OcrData ocrData)? onOcrRead;

  // final void Function() onPermissionDenied;
  final ArtemisOcrScannerController? controller;
  final UsageMode mode;
  final FlashMode initFlash;
  final bool fill;
  final CameraType cameraType;

  const ArtemisOcrScannerView(
      {Key? key,
      this.controller,
      this.mode = UsageMode.ocrReader,
      this.initFlash = FlashMode.auto,
      this.fill = true,
      this.cameraType = CameraType.back, this.onOcrRead})
      : super(key: key);

  @override
  State<ArtemisOcrScannerView> createState() => _ArtemisOcrScannerViewState();
}

class _ArtemisOcrScannerViewState extends State<ArtemisOcrScannerView> with WidgetsBindingObserver {
  late VisibilityDetector visibilityDetector;
  late ArtemisOcrScannerController controller;
  static const String viewType = '<ocr-scanner-view-type>';

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    controller = widget.controller ?? ArtemisOcrScannerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.

    // Pass parameters to the platform side.
    // const Map<String, dynamic> creationParams = <String, dynamic>{};

    return VisibilityDetector(
      key: const Key(viewType),
      onVisibilityChanged: _handleVisibilityChange,
      child: _buildView(),
    );
  }

  Widget _buildView() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return VisibilityDetector(
            key: const Key(viewType),
            onVisibilityChanged: _handleVisibilityChange,
            child: AndroidView(
              viewType: viewType,
              onPlatformViewCreated: _onPlatformViewCreated,
            ));
      case TargetPlatform.fuchsia:
        throw UnsupportedError('Unsupported platform view');
      case TargetPlatform.iOS:
        return VisibilityDetector(
            key: const Key(viewType),
            onVisibilityChanged: _handleVisibilityChange,
            child: UiKitView(
              viewType: viewType,
              onPlatformViewCreated: _onPlatformViewCreated,
            ));
      case TargetPlatform.linux:
        throw UnsupportedError('Unsupported platform view');
      case TargetPlatform.macOS:
        throw UnsupportedError('Unsupported platform view');
      case TargetPlatform.windows:
        throw UnsupportedError('Unsupported platform view');
    }
  }

  void _onPlatformViewCreated(int id) {
    controller.getCameraPermission().then((value) {
      if (value!) {
        controller.initCamera(
          fill: widget.fill,
          mode: widget.mode,
          initFlash: widget.initFlash,
          cameraType: widget.cameraType,
        );

        controller.setMethodCallHandler(handler: _methodCallHandler);
      } else {
        _onPlatformViewCreated(id);
      }
    });
  }

  void _handleVisibilityChange(VisibilityInfo info) {
    if (info.visibleFraction == 0) {
      controller.changeCameraVisibility(visibility: false);
    } else {
      controller.changeCameraVisibility(visibility: true);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // print("Flutter Life Cycle: resumed");
        controller.resumeCamera();
        break;
      case AppLifecycleState.inactive:
        // print("Flutter Life Cycle: inactive");
        // if (Platform.isIOS) {
        controller.pauseCamera();
        // }
        break;
      case AppLifecycleState.paused:
        // print("Flutter Life Cycle: paused");
        controller.pauseCamera();
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<dynamic> _methodCallHandler(MethodCall methodCall) async {


    if(methodCall.method == "onTextRead"){
      String? ocrJson = await methodCall.arguments;
      if (ocrJson == null) return null;
      try {
        OcrData ocrData = OcrData.fromJson(jsonDecode(ocrJson));
        if (widget.onOcrRead == null) {
          log("Text ${ocrData.text} Detected but no onOcrRead is not  Implemented");
        } else {
          widget.onOcrRead!(ocrData);
        }
      } catch (e) {
        return null;
      }
    }

  }
}
