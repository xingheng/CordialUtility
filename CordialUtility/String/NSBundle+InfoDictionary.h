//
//  NSBundle+InfoDictionary.h
//  1PasswordExtension
//
//  Created by WeiHan on 2018/8/23.
//

#import <Foundation/Foundation.h>

@interface NSBundle (InfoDictionary)

+ (NSDictionary *)mainBundleInfo;

+ (NSString *)mainBundleDisplayName;

+ (NSString *)mainBundleShortVersion;

+ (NSString *)mainBundleFullVersion;

@end
