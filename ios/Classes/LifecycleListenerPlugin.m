#import "LifecycleListenerPlugin.h"
#import <lifecycle_listener/lifecycle_listener-Swift.h>

@implementation LifecycleListenerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLifecycleListenerPlugin registerWithRegistrar:registrar];
}
@end
