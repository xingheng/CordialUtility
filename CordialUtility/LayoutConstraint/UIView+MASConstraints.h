//
//  UIView+MASConstraints.h
//
//  Created by WeiHan on 2018/9/29.
//

@class MASConstraint;

@interface UIView (MASConstraints)

#define DeclareConstraint(_name_) \
    @property (nonatomic, strong) MASConstraint *mas_ ## _name_ ## Constraint;

DeclareConstraint(left);
DeclareConstraint(top);
DeclareConstraint(right);
DeclareConstraint(bottom);
DeclareConstraint(leading);
DeclareConstraint(trailing);
DeclareConstraint(width);
DeclareConstraint(height);
DeclareConstraint(centerX);
DeclareConstraint(centerY);
DeclareConstraint(baseline);

@end
