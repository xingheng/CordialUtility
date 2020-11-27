//
//  UIColor+HexString.m
//
//  Created by WeiHan on 16/8/9.
//  Copyright © 2016 WeiHan. All rights reserved.
//

#import "UIColor+HexString.h"

@implementation UIColor (HexString)

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

    if ([cString length] < 6) {
        return [UIColor clearColor];
    }

    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }

    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }

    if ([cString length] != 6) {
        return [UIColor clearColor];
    }

    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];

    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}

- (NSString *)hexStringFromColorWithAlpha:(out CGFloat *)alpha
{
    CGFloat r, g, b, a;

    if (![self getRed:&r green:&g blue:&b alpha:&a]) {
        NSAssert(NO, @"Must be a RGB color to use hexStringFromColor");
    }

    // Fix range if needed
    r = MAX(MIN(r, 1.0f), 0.0f);
    g = MAX(MIN(g, 1.0f), 0.0f);
    b = MAX(MIN(b, 1.0f), 0.0f);
    a = MAX(MIN(a, 1.0f), 0.0f);

    if (alpha) {
        *alpha = a;
    }

    // Convert to hex string between 0x00 and 0xFF
    return [NSString stringWithFormat:@"#%02X%02X%02X", (int)(r * 255), (int)(g * 255), (int)(b * 255)];
}

- (NSString *)hexStringFromColor
{
    return [self hexStringFromColorWithAlpha:nil];
}

@end
