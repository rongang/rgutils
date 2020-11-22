#import "RgutilsPlugin.h"
#if __has_include(<rgutils/rgutils-Swift.h>)
#import <rgutils/rgutils-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "rgutils-Swift.h"
#endif

@implementation RgutilsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftRgutilsPlugin registerWithRegistrar:registrar];
}
@end
