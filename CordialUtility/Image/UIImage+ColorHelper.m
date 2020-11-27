//
//  UIImage+ColorHelper.m
//
//  Created by WeiHan on 1/4/16.
//  Copyright © 2016 WeiHan. All rights reserved.
//
//  Topic link: http://stackoverflow.com/a/993159/1677041

#import "UIImage+ColorHelper.h"

@implementation UIImage (ColorHelper)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [self imageWithColor:color size:CGSizeMake(1.0f, 1.0f)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    return [self imageWithColor:color width:size.width height:size.height];
}

+ (UIImage *)imageWithColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height
{
    CGRect rect = CGRectMake(0.0f, 0.0f, width, height);

    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

@end


UIImage * UIImageWithColor(UIColor *color)
{
    return [UIImage imageWithColor:color];
}

UIImage * UIImageWithColorEx(UIColor *color, CGFloat width)
{
    return [UIImage imageWithColor:color width:width height:width];
}
