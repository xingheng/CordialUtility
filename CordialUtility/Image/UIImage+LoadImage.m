//
//  UIImage+LoadImage.m
//
//  Created by WeiHan on 12/28/16.
//

#import "UIImage+LoadImage.h"

UIImage * LoadImageFromBundle(NSString *image, NSString *bundleName)
{
    static NSBundle *bundle = nil;
    static dispatch_once_t onceToken;
    NSString *const type = @"bundle";

    if (![bundle.bundlePath hasSuffix:[NSString stringWithFormat:@"%@.%@", bundleName, type]]) {
        onceToken = 0L;
    }

    dispatch_once(&onceToken, ^{
        NSString *strPath = [[NSBundle mainBundle] pathForResource:bundleName ofType:type];
        NSCAssert(strPath, @"Failed to get the bundle path!");
        bundle = [NSBundle bundleWithPath:strPath];
    });

    return [UIImage imageNamed:image inBundle:bundle compatibleWithTraitCollection:nil];
}

@implementation UIImage (LoadImage)

+ (instancetype)imageNamed:(NSString *)image inBundle:(NSBundle *)bundle
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        return [UIImage imageNamed:image inBundle:bundle compatibleWithTraitCollection:nil];
    } else {
        NSString *strPath = [bundle pathForResource:image ofType:@"png"];

        if (strPath.length <= 0) {
            strPath =  [bundle pathForResource:image ofType:@"jpg"];
        }

        if (strPath.length <= 0) {
            strPath =  [bundle pathForResource:image ofType:@"jpeg"];
        }

        // Okay, stop guessing.

        return [UIImage imageWithContentsOfFile:strPath];
    }
}

@end
