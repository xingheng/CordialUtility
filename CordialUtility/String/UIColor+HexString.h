//
//  UIColor+HexString.h
//
//  Created by WeiHan on 16/8/9.
//  Copyright © 2016 WeiHan. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef RGBA
    #define RGBA(__r, __g, __b, __a)        \
    [UIColor colorWithRed: ((__r) / 255.0f) \
 green: ((__g) / 255.0f)                    \
 blue: ((__b) / 255.0f)                     \
 alpha: (__a)]

    #define RGB(__r, __g, __b) RGBA(__r, __g, __b, 1.0)
#endif


@interface UIColor (HexString)

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)color;

- (NSString *)hexStringFromColorWithAlpha:(out CGFloat *)alpha;

- (NSString *)hexStringFromColor;

@end
