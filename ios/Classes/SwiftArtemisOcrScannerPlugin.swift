import Flutter
import UIKit

public class SwiftArtemisOcrScannerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "artemis_ocr_scanner", binaryMessenger: registrar.messenger())
    let instance = SwiftArtemisOcrScannerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    let factory = OcrScannerViewFactory(messenger: registrar.messenger())
    registrar.register(factory, withId: "<ocr-scanner-view-type>")
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
