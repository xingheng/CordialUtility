//
//  ViewControllerHelper.m
//
//  Created by WeiHan on 5/3/16.
//  Copyright © 2016 WeiHan. All rights reserved.
//

#import "ViewControllerHelper.h"

@implementation ViewControllerHelper

+ (UIViewController *)recursiveTopMostViewController:(UIViewController *)viewController identify:(UIViewController * (^)(UIViewController *))identifyBlock
{
    if (viewController.presentedViewController) {
        return [[self class] recursiveTopMostViewController:viewController.presentedViewController identify:nil];
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        return [[self class] recursiveTopMostViewController:[(UITabBarController *)viewController selectedViewController] identify:nil];
    } else if ([viewController isKindOfClass:[UINavigationController class]]) {
        return [[self class] recursiveTopMostViewController:[(UINavigationController *)viewController visibleViewController] identify:nil];
    } else {
        if (identifyBlock) {
            UIViewController *mappedVC = identifyBlock(viewController);

            if (![mappedVC isEqual:viewController]) {
                return [[self class] recursiveTopMostViewController:mappedVC identify:[identifyBlock copy]];
            }
        }

        return viewController;
    }
}

+ (UIViewController *)topViewController
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    if (!window) {
        window = [[UIApplication sharedApplication].windows firstObject];
    }

    UIViewController *vc = window.rootViewController;

    return [[self class] recursiveTopMostViewController:vc identify:nil];
}

@end


@implementation UIViewController (TopViewController)

- (UIViewController *)topViewController
{
    return [[ViewControllerHelper class] recursiveTopMostViewController:self identify:nil];
}

@end


// This macro is NOT recommended! DO NOT overuse it.
// Source: https://stackoverflow.com/a/24590678/1677041
UIViewController * GetViewParentController(UIView *view)
{
    UIResponder *responder = view;

    while ([responder isKindOfClass:[UIView class]])
        responder = [responder nextResponder];

    return (UIViewController *)responder;
}
