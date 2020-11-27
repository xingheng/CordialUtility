//
//  UIView+EdgeBorder.m
//
//  Created by WeiHan on 6/6/17.
//  Copyright © 2017 WeiHan. All rights reserved.
//
//  Inspired from https://stackoverflow.com/a/23157272/1677041
//

#import "UIView+EdgeBorder.h"

@implementation UIView (EdgeBorder)

#pragma mark - Public

- (void)setEdgeBorder:(UIRectEdge)option color:(UIColor *)color
{
    [self setEdgeBorder:option color:color thickness:1.0];
}

- (void)setEdgeBorder:(UIRectEdge)option color:(UIColor *)color thickness:(CGFloat)thickness
{
    [self setEdgeBorder:option color:color thickness:thickness configuration:nil];
}

- (void)setEdgeBorder:(UIRectEdge)option color:(UIColor *)color thickness:(CGFloat)thickness configuration:(void (^)(UIRectEdge option, UIView *border))block
{
#define EdgeConstraint(__attribute__, __view__)      [NSLayoutConstraint constraintWithItem: __view__ attribute: __attribute__ relatedBy: NSLayoutRelationEqual toItem: self attribute: __attribute__ multiplier: 1.0 constant : 0].active = YES

#define WidthConstraint(__const_height__, __view__)  [NSLayoutConstraint constraintWithItem: __view__ attribute: NSLayoutAttributeWidth relatedBy: NSLayoutRelationEqual toItem: nil attribute: NSLayoutAttributeNotAnAttribute multiplier : 0 constant: __const_height__].active = YES

#define HeightConstraint(__const_height__, __view__) [NSLayoutConstraint constraintWithItem:__view__ attribute: NSLayoutAttributeHeight relatedBy: NSLayoutRelationEqual toItem: nil attribute: NSLayoutAttributeNotAnAttribute multiplier : 0 constant: __const_height__].active = YES

    UIView * (^ createBorder)(UIRectEdge) = ^UIView *(UIRectEdge op) {
        UIView *border = [UIView new];

        border.translatesAutoresizingMaskIntoConstraints = NO;
        border.backgroundColor = color;
        border.tag = op;
        !block ? : block(op, border);
        [self addSubview:border];
        return border;
    };

    if (option & UIRectEdgeTop) {
        UIView *view = createBorder(UIRectEdgeTop);

        EdgeConstraint(NSLayoutAttributeTop, view);
        EdgeConstraint(NSLayoutAttributeLeft, view);
        EdgeConstraint(NSLayoutAttributeRight, view);
        HeightConstraint(thickness, view);
    }

    if (option & UIRectEdgeLeft) {
        UIView *view = createBorder(UIRectEdgeLeft);

        EdgeConstraint(NSLayoutAttributeTop, view);
        EdgeConstraint(NSLayoutAttributeLeft, view);
        EdgeConstraint(NSLayoutAttributeBottom, view);
        WidthConstraint(thickness, view);
    }

    if (option & UIRectEdgeBottom) {
        UIView *view = createBorder(UIRectEdgeBottom);

        EdgeConstraint(NSLayoutAttributeLeft, view);
        EdgeConstraint(NSLayoutAttributeRight, view);
        EdgeConstraint(NSLayoutAttributeBottom, view);
        HeightConstraint(thickness, view);
    }

    if (option & UIRectEdgeRight) {
        UIView *view = createBorder(UIRectEdgeRight);

        EdgeConstraint(NSLayoutAttributeTop, view);
        EdgeConstraint(NSLayoutAttributeRight, view);
        EdgeConstraint(NSLayoutAttributeBottom, view);
        WidthConstraint(thickness, view);
    }
}

- (UIView *)borderForEdge:(UIRectEdge)option
{
    for (UIView *view in self.subviews) {
        if (view.tag == option) {
            return view;
        }
    }

    return nil;
}

@end
