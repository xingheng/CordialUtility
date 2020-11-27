//
//  UIImage+ColorHelper.h
//
//  Created by WeiHan on 1/4/16.
//  Copyright © 2016 WeiHan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ColorHelper)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height;

@end

UIImage * UIImageWithColor(UIColor *color);
UIImage * UIImageWithColorEx(UIColor *color, CGFloat width);
