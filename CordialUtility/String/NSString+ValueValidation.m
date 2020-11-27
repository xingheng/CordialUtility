//
//  NSString+ValueValidation.m
//
//  Created by WeiHan on 1/19/16.
//  Copyright © 2016 WeiHan. All rights reserved.
//

#import "NSString+ValueValidation.h"

@implementation NSString (ValueValidation)

- (NSString *)trimEmptySpace
{
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    return trimmedString;
}

//
// Solution from http://stackoverflow.com/a/5081447/1677041
//
- (BOOL)isURLString
{
    NSURL *url = [NSURL URLWithString:self];

    return url && url.scheme && url.host;
}

- (BOOL)isHTTPURLString
{
    NSURL *url = [NSURL URLWithString:self];

    return url && url.scheme && url.host && [url.scheme hasPrefix:@"http"];
}

@end
