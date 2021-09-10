/**
 * ti.colorwheel
 *
 * Created by Your Name
 * Copyright (c) 2021 Your Company. All rights reserved.
 */

#import "TiColorwheelModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation TiColorwheelModule

#pragma mark Internal

// This is generated for your module, please do not change it
- (id)moduleGUID
{
  return @"878888d0-e135-4092-a66e-6234148d32c8";
}

// This is generated for your module, please do not change it
- (NSString *)moduleId
{
  return @"ti.colorwheel";
}

#pragma mark Lifecycle

- (void)startup
{
  // This method is called when the module is first loaded
  // You *must* call the superclass
    if ([TiUtils isIOSVersionOrGreater:@"14.0"]){
        [super startup];
        DebugLog(@"[DEBUG] %@ loaded", self);
    }
    else{
        DebugLog(@"[DEBUG] %@ NOT loaded iOS version MUST be 14+", self);
    }
}

#pragma Public APIs

- (NSNumber *)isSupported:(id)unused
{
    return @([TiUtils isIOSVersionOrGreater:@"14.0"]);
}

@end
