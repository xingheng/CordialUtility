//
//  UIView+ViewHierarchy.h
//
//  Created by WeiHan on 1/19/16.
//  Copyright © 2016 WeiHan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ViewHierarchy)

- (void)addSubviews:(UIView *)firstView, ...NS_REQUIRES_NIL_TERMINATION;

@end
