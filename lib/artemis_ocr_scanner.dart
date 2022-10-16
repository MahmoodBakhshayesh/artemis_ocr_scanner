
import 'package:flutter/services.dart';

import 'artemis_ocr_scanner_platform_interface.dart';

class ArtemisOcrScanner {
  Future<String?> getPlatformVersion() {
    return ArtemisOcrScannerPlatform.instance.getPlatformVersion();
  }

  Future<bool?> getCameraPermission() {
    return ArtemisOcrScannerPlatform.instance.getCameraPermission();
  }

  Future<void> initCamera({
    FlashMode initFlash = FlashMode.auto,
    bool fill = true,
    CameraType cameraType = CameraType.back,
    UsageMode mode = UsageMode.ocrReader,
  }) {
    return ArtemisOcrScannerPlatform.instance.initCamera(
        mode: mode,
        initFlash: initFlash,
        fill: fill,
        cameraType: cameraType);
  }

  Future<void> changeFlashMode({required FlashMode mode}) {
    return ArtemisOcrScannerPlatform.instance.changeFlashMode(mode);
  }

  Future<void> changeCameraVisibility({required bool visibility}) {
    return ArtemisOcrScannerPlatform.instance.changeCameraVisibility(visibility);
  }

  Future<void> pauseCamera() {
    return ArtemisOcrScannerPlatform.instance.pauseCamera();
  }

  Future<void> resumeCamera() {
    return ArtemisOcrScannerPlatform.instance.resumeCamera();
  }

  Future<String?> takePicture([String path = ""]) {
    return ArtemisOcrScannerPlatform.instance.takePicture(path);
  }

  Future<OcrData?> processImageFromPath([String path = ""]) {
    return ArtemisOcrScannerPlatform.instance.processImageFromPath(path);
  }

  Future<void> setMethodCallHandler({required Future<dynamic> Function(MethodCall call)? handler}) {
    return ArtemisOcrScannerPlatform.instance.setMethodCallHandler(handler);
  }
}
