//
//  UIView+BlockAction.m
//
//  Created by WeiHan on 5/26/17.
//  Copyright © 2017 WeiHan. All rights reserved.
//

#import <objc/runtime.h>
#import "UIView+BlockAction.h"

#pragma mark - UIGestureRecognizer (BlockAction)

@interface UIGestureRecognizer (_BlockAction)

@property (nonatomic, strong, readonly) NSMutableSet<GestureActionBlockType> *gestureActionBlocks;

@end

@implementation UIGestureRecognizer (BlockAction)

- (void)addActionBlock:(GestureActionBlockType)block
{
    [self addTarget:self action:@selector(bk_gestureHandlerAction:)];
    [self.gestureActionBlocks addObject:block];
}

- (void)removeAllActionBlocks
{
    [self removeTarget:self action:@selector(bk_gestureHandlerAction:)];
    [self.gestureActionBlocks removeAllObjects];
}

#pragma mark - Property

- (NSMutableSet<GestureActionBlockType> *)gestureActionBlocks
{
    NSMutableSet *blocks = objc_getAssociatedObject(self, _cmd);

    if (!blocks) {
        blocks = [NSMutableSet new];
        objc_setAssociatedObject(self, _cmd, blocks, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    return blocks;
}

#pragma mark - Actions

- (void)bk_gestureHandlerAction:(id)sender
{
    UIGestureRecognizer *gesture = sender;

    for (GestureActionBlockType block in gesture.gestureActionBlocks) {
        block(sender);
    }
}

@end

#pragma mark - UIView (BlockAction)

@implementation UIView (BlockAction)

- (UITapGestureRecognizer *)addTapGestureRecognizer:(GestureActionBlockType)block
{
    return [self addGestureRecognizer:UITapGestureRecognizer.class action:block];
}

- (__kindof UIGestureRecognizer *)addGestureRecognizer:(Class)gestureRecognizerClass action:(GestureActionBlockType)block
{
    UIGestureRecognizer *gesture = [gestureRecognizerClass new];

    if (![gesture isKindOfClass:UIGestureRecognizer.class]) {
        return nil;
    }

    [gesture addActionBlock:block];

    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:gesture];

    return gesture;
}

@end
