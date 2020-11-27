//
//  NSBundle+InfoDictionary.m
//  1PasswordExtension
//
//  Created by WeiHan on 2018/8/23.
//

#import "NSBundle+InfoDictionary.h"

@implementation NSBundle (InfoDictionary)

+ (NSDictionary *)mainBundleInfo
{
    return NSBundle.mainBundle.infoDictionary;
}

+ (NSString *)mainBundleDisplayName
{
    return self.mainBundleInfo[@"CFBundleDisplayName"];
}

+ (NSString *)mainBundleShortVersion
{
    return self.mainBundleInfo[@"CFBundleShortVersionString"];
}

+ (NSString *)mainBundleFullVersion
{
    return [[self mainBundleShortVersion] stringByAppendingFormat:@".%@", self.mainBundleInfo[@"CFBundleVersion"]];
}

@end
