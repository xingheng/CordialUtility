//
//  NSString+ValueValidation.h
//
//  Created by WeiHan on 1/19/16.
//  Copyright © 2016 WeiHan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ValueValidation)

- (NSString *)trimEmptySpace;

- (BOOL)isURLString;
- (BOOL)isHTTPURLString;

@end
