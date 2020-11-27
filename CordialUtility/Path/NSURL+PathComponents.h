//
//  NSURL+PathComponents.h
//
//  Created by WeiHan on 11/22/16.
//  Copyright © 2016 WeiHan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (PathComponents)

- (NSURL *)URLByAppendingQueryPathComponent:(NSDictionary<NSString *, NSString *> *)dictComponent;

- (NSURL *)URLByDeletingQueryPathComponent:(NSArray<NSString *> *)arrQueryComponent;

@end
