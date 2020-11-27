//
//  UIControl+BlockAction.h
//
//  Created by WeiHan on 5/26/17.
//

#import <UIKit/UIKit.h>

typedef void (^EventActionBlockType)(id sender);

@interface UIControl (BlockAction)

- (void)addEventBlock:(EventActionBlockType)block forControlEvents:(UIControlEvents)controlEvents;

@end
