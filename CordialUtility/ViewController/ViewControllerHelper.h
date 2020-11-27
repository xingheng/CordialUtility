//
//  ViewControllerHelper.h
//
//  Created by WeiHan on 5/3/16.
//  Copyright © 2016 WeiHan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewControllerHelper : NSObject

+ (UIViewController *)recursiveTopMostViewController:(UIViewController *)viewController identify:(UIViewController * (^)(UIViewController *))identifyBlock;

+ (UIViewController *)topViewController;

@end


@interface UIViewController (TopViewController)

- (UIViewController *)topViewController;

@end


UIViewController * GetViewParentController(UIView *view);
