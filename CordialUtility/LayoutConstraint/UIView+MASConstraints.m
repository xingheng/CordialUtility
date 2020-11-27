//
//  UIView+MASConstraints.m
//
//  Created by WeiHan on 2018/9/29.
//

#import <objc/runtime.h>
#import "UIView+MASConstraints.h"

@implementation UIView (MASConstraints)

#define DefineConstraint(_name_)                                                                                           \
    - (void)setMas_ ## _name_ ## Constraint:(MASConstraint *)constaint                                                     \
    {                                                                                                                      \
        objc_setAssociatedObject(self, @selector(mas_##_name_##Constraint), constaint, OBJC_ASSOCIATION_RETAIN_NONATOMIC); \
    }                                                                                                                      \
                                                                                                                           \
    - (MASConstraint *)mas_ ## _name_ ## Constraint                                                                        \
    {                                                                                                                      \
        return objc_getAssociatedObject(self, _cmd);                                                                       \
    }

DefineConstraint(left);
DefineConstraint(top);
DefineConstraint(right);
DefineConstraint(bottom);
DefineConstraint(leading);
DefineConstraint(trailing);
DefineConstraint(width);
DefineConstraint(height);
DefineConstraint(centerX);
DefineConstraint(centerY);
DefineConstraint(baseline);

@end
