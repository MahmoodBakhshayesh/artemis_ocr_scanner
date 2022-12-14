#import "ArtemisOcrScannerPlugin.h"
#if __has_include(<artemis_ocr_scanner/artemis_ocr_scanner-Swift.h>)
#import <artemis_ocr_scanner/artemis_ocr_scanner-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "artemis_ocr_scanner-Swift.h"
#endif

@implementation ArtemisOcrScannerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftArtemisOcrScannerPlugin registerWithRegistrar:registrar];
}
@end
