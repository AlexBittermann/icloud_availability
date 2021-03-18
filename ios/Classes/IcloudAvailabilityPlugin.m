#import "IcloudAvailabilityPlugin.h"
#if __has_include(<icloud_availability/icloud_availability-Swift.h>)
#import <icloud_availability/icloud_availability-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "icloud_availability-Swift.h"
#endif

@implementation IcloudAvailabilityPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftIcloudAvailabilityPlugin registerWithRegistrar:registrar];
}
@end
