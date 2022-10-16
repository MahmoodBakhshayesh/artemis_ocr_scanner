import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'artemis_ocr_scanner_method_channel.dart';

abstract class ArtemisOcrScannerPlatform extends PlatformInterface {
  /// Constructs a ArtemisOcrScannerPlatform.
  ArtemisOcrScannerPlatform() : super(token: _token);

  static final Object _token = Object();

  static ArtemisOcrScannerPlatform _instance = MethodChannelArtemisOcrScanner();

  /// The default instance of [ArtemisOcrScannerPlatform] to use.
  ///
  /// Defaults to [MethodChannelArtemisOcrScanner].
  static ArtemisOcrScannerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ArtemisOcrScannerPlatform] when
  /// they register themselves.
  static set instance(ArtemisOcrScannerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> getCameraPermission() {
    throw UnimplementedError('cameraPermission() has not been implemented.');
  }

  Future<void> initCamera({
    required FlashMode initFlash,
    required bool fill,
    required CameraType cameraType,
    required UsageMode mode,
  }) {
    throw UnimplementedError('initCamera() has not been implemented.');
  }

  Future<void> pauseCamera() {
    throw UnimplementedError('pauseCamera() has not been implemented.');
  }

  Future<void> resumeCamera() {
    throw UnimplementedError('resumeCamera() has not been implemented.');
  }

  Future<void> changeFlashMode(FlashMode flashMode) {
    throw UnimplementedError('changeFlashMode() has not been implemented.');
  }

  Future<String?> takePicture([String path = ""]) {
    throw UnimplementedError('takePicture() has not been implemented.');
  }

  Future<OcrData?> processImageFromPath([String path = ""]) {
    throw UnimplementedError('processImageFromPath() has not been implemented.');
  }

  Future<void> dispose() {
    throw UnimplementedError('dispose() has not been implemented.');
  }

  Future<void> changeCameraVisibility(bool visibility) {
    throw UnimplementedError('changeCameraVisibility() has not been implemented!.');
  }

  Future<void> setMethodCallHandler(Future<dynamic> Function(MethodCall call)? handler) {
    throw UnimplementedError('setMethodCallHandler() has not been implemented.');
  }
}

enum CameraType { back, front }

enum FlashMode { on, off, auto }

enum UsageMode { camera,ocrReader}

extension FlashModeDetails on FlashMode {
  int get id {
    switch (this) {
      case FlashMode.on:
        return 1;
      case FlashMode.off:
        return 0;
      case FlashMode.auto:
        return 2;
    }
  }
}

extension CameraTypeDetails on CameraType {
  int get id {
    switch (this) {
      case CameraType.back:
        return 0;
      case CameraType.front:
        return 1;
    }
  }
}

extension UsageModeDetails on UsageMode {
  int get id {
    switch (this) {
      case UsageMode.camera:
        return 0;
      case UsageMode.ocrReader:
        return 2;
    }
  }
}


class OcrData {
  OcrData({
    required this.text,
    this.path = "",
    this.orientation = 0,
    required this.lines,
  });

  String text;
  String path;
  int orientation;
  List<OcrLine> lines;

  factory OcrData.fromJson(Map<String, dynamic> json) => OcrData(
    text: json["text"],
    path: json["path"]??"",
    orientation: json["orientation"]??0,
    lines: List<OcrLine>.from((json["lines"]??[]).map((x) => OcrLine.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "path": path,
    "orientation": orientation,
    "lines": List<dynamic>.from(lines.map((x) => x.toJson())),
  };
}

class OcrLine {
  OcrLine({
    required this.text,
    required this.cornerPoints,
  });

  String text;
  List<OcrPoint> cornerPoints;

  factory OcrLine.fromJson(Map<String, dynamic> json) => OcrLine(
    text: json["text"]??json["a"]??"",
    cornerPoints: List<OcrPoint>.from((json["cornerPoints"]??json["b"]??[]).map((x) => OcrPoint.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "cornerPoints": List<dynamic>.from(cornerPoints.map((x) => x.toJson())),
  };
}

class OcrPoint {
  OcrPoint({
    required this.x,
    required this.y,
  });

  double x;
  double y;

  factory OcrPoint.fromJson(Map<String, dynamic> json) => OcrPoint(
    x: (json["x"]??json["a"]).toDouble(),
    y: (json["y"]??json["b"]).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "x": x,
    "y": y,
  };
}

