//
//  UIView+ViewHierarchy.m
//
//  Created by WeiHan on 1/19/16.
//  Copyright © 2016 WeiHan. All rights reserved.
//
//  About va_list on Objective-C: https://developer.apple.com/library/mac/qa/qa1405/_index.html
//

#import "UIView+ViewHierarchy.h"

@implementation UIView (ViewHierarchy)

- (void)addSubviews:(UIView *)firstView, ...
{
    id eachObject;
    va_list argumentList;

    if (firstView) {
        // The first argument isn't part of the varargs list, so we'll handle it separately.
        [self addSubview:firstView];

        // Start scanning for arguments after firstObject.
        va_start(argumentList, firstView);

        // As many times as we can get an argument of type "id"
        while ((eachObject = va_arg(argumentList, UIView *)))
            // that isn't nil, add it to self's contents.
            [self addSubview:eachObject];

        va_end(argumentList);
    }
}

@end
