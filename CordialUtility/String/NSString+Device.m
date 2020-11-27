//
//  NSString+Device.m
//
//  Created by WeiHan on 2018/10/23.
//

#import <sys/utsname.h>
#import "NSString+Device.h"

NSString * GetDeviceModel(void)
{
    static dispatch_once_t onceToken;
    static NSString *strModelID = nil;

    dispatch_once(&onceToken, ^{
#if TARGET_IPHONE_SIMULATOR
        strModelID = NSProcessInfo.processInfo.environment[@"SIMULATOR_MODEL_IDENTIFIER"];
#else
        struct utsname systemInfo;

        uname(&systemInfo);
        strModelID = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
#endif
    });

    return strModelID;
}

// See the `Hardware strings` in https://en.wikipedia.org/wiki/List_of_iOS_devices
BOOL IsiPhoneX(void)
{
    NSString *strModelID = GetDeviceModel();

    return [strModelID isEqualToString:@"iPhone10,3"] || [strModelID isEqualToString:@"iPhone10,6"];
}

BOOL IsNotchiPhone(void)
{
    NSArray<NSString *> *notchiModels = @[
        @"iPhone10,3", @"iPhone10,6", // iPhone X
        @"iPhone11,2", @"iPhone11,4", @"iPhone11,6", // iPhone XS (Max)
        @"iPhone11,8", // iPhone XR
        @"iPhone12,1", @"iPhone12,3", @"iPhone12,5", // iPhone 11 (Pro (Max))
        @"iPhone13,1", @"iPhone13,2", @"iPhone13,3", @"iPhone13,4", // iPhone 12 ([mini]|[Pro (Max)])
    ];

    return [notchiModels containsObject:GetDeviceModel()];
}

@implementation NSString (Device)

+ (NSString *)deviceModel
{
    return GetDeviceModel();
}

@end
