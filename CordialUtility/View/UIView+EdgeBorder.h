//
//  UIView+EdgeBorder.h
//
//  Created by WeiHan on 6/6/17.
//  Copyright © 2017 WeiHan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (EdgeBorder)

- (void)setEdgeBorder:(UIRectEdge)option color:(UIColor *)color;

- (void)setEdgeBorder:(UIRectEdge)option color:(UIColor *)color thickness:(CGFloat)thickness;

- (void)setEdgeBorder:(UIRectEdge)option color:(UIColor *)color thickness:(CGFloat)thickness configuration:(void (^)(UIRectEdge option, UIView *border))block;

- (UIView *)borderForEdge:(UIRectEdge)option;

@end
