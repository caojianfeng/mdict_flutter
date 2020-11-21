#import "MdictFlutterPlugin.h"
#if __has_include(<mdict_flutter/mdict_flutter-Swift.h>)
#import <mdict_flutter/mdict_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "mdict_flutter-Swift.h"
#endif

@implementation MdictFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMdictFlutterPlugin registerWithRegistrar:registrar];
}
@end
