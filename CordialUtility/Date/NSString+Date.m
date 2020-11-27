//
//  NSString+Date.m
//
//  Created by WeiHan on 3/7/16.
//  Copyright © 2016 WeiHan. All rights reserved.
//

#import "NSString+Date.h"

#pragma mark - Functions

static inline NSDateFormatter * GetDataFormatter()
{
    static NSDateFormatter *gDataFormatter = nil;

    if (!gDataFormatter) {
        gDataFormatter = [NSDateFormatter new];
    }

    return gDataFormatter;
}

NSString * GetStringFromDate(NSDate *date, NSString *dateFormat)
{
    NSDateFormatter *formatter = GetDataFormatter();

    formatter.dateFormat = dateFormat;
    return [formatter stringFromDate:date];
}

NSDate * GetDateFromString(NSString *strDate, NSString *dateFormat)
{
    NSDateFormatter *formatter = GetDataFormatter();

    formatter.dateFormat = dateFormat;
    return [formatter dateFromString:strDate];
}

#pragma mark - NSString (DateFormat)

@implementation NSString (DateFormat)

- (NSDate *)dateFromStringFormat:(NSString *)format
{
    return GetDateFromString(self, format);
}

+ (NSString *)stringFromDate:(NSDate *)date dateFormat:(NSString *)format
{
    return GetStringFromDate(date, format);
}

@end

#pragma mark - NSDate (StringFormat)

@implementation NSDate (StringFormat)

- (NSString *)stringFromDateFormat:(NSString *)format
{
    return GetStringFromDate(self, format);
}

+ (NSDate *)dateFromString:(NSString *)string dateFormat:(NSString *)format
{
    return GetDateFromString(string, format);
}

@end
