//
//  UIView+BlockAction.h
//
//  Created by WeiHan on 5/26/17.
//  Copyright © 2017 WeiHan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GestureActionBlockType)(__kindof UIGestureRecognizer *sender);

@interface UIGestureRecognizer (BlockAction)

- (void)addActionBlock:(GestureActionBlockType)block;

- (void)removeAllActionBlocks;

@end

@interface UIView (BlockAction)

- (UITapGestureRecognizer *)addTapGestureRecognizer:(GestureActionBlockType)block;

- (__kindof UIGestureRecognizer *)addGestureRecognizer:(Class)gestureRecognizerClass action:(GestureActionBlockType)block;

@end
