//
//  AlertHelper.m
//
//  Created by WeiHan on 1/25/16.
//  Copyright © 2016 WeiHan. All rights reserved.
//

#import "AlertHelper.h"

@implementation AlertHelper

- (void)addAction:(nullable NSString *)actionTitle style:(UIAlertActionStyle)style handler:(void (^__nullable)(UIAlertAction *__nullable action))actionBlock
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle
                                                     style:style
                                                   handler:actionBlock];

    [self addAction:action];
}

- (void)addDefaultAction:(nullable NSString *)actionTitle handler:(void (^__nullable)(UIAlertAction *__nullable action))actionBlock
{
    [self addAction:actionTitle style:UIAlertActionStyleDefault handler:actionBlock];
}

- (void)addDestructiveAction:(nullable NSString *)actionTitle handler:(void (^__nullable)(UIAlertAction *__nullable action))actionBlock
{
    [self addAction:actionTitle style:UIAlertActionStyleDestructive handler:actionBlock];
}

- (void)addCancelAction:(nullable NSString *)actionTitle handler:(void (^__nullable)(UIAlertAction *__nullable action))actionBlock
{
    [self addAction:actionTitle style:UIAlertActionStyleCancel handler:actionBlock];
}

- (void)presentInViewController:(nonnull UIViewController *)sourceViewController
{
    NSParameterAssert(sourceViewController);

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.popoverPresentationController.permittedArrowDirections = 0;

        self.popoverPresentationController.sourceView = sourceViewController.view;
        self.popoverPresentationController.sourceRect = sourceViewController.view.bounds;
    }

    [sourceViewController presentViewController:self animated:YES completion:nil];
}

@end
