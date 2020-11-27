//
//  NSString+Date.h
//
//  Created by WeiHan on 3/7/16.
//  Copyright © 2016 WeiHan. All rights reserved.
//
//  Date format by country: https://en.wikipedia.org/wiki/Date_format_by_country
//  Unix Time: https://en.wikipedia.org/wiki/Unix_time
//

#import <Foundation/Foundation.h>

#define kCurrentReferenceTimeInterval    [[NSDate date] timeIntervalSinceReferenceDate]
#define kCurrentUnixTimeInterval         [[NSDate date] timeIntervalSince1970]

#define kDateFormat_Date_Time_MiniSecond @"yyyy-MM-dd HH:mm:ss.SSS"
#define kDateFormat_Date_Time_Second     @"yyyy-MM-dd HH:mm:ss"
#define kDateFormat_Date                 @"yyyy-MM-dd"
#define kDateFormat_Time                 @"MM dd yyyy"

NSString * GetStringFromDate(NSDate *date, NSString *dateFormat);

NSDate * GetDateFromString(NSString *strDate, NSString *dateFormat);


@interface NSString (DateFormat)

- (NSDate *)dateFromStringFormat:(NSString *)format;

+ (NSString *)stringFromDate:(NSDate *)date dateFormat:(NSString *)format;

@end


@interface NSDate (StringFormat)

- (NSString *)stringFromDateFormat:(NSString *)format;

+ (NSDate *)dateFromString:(NSString *)string dateFormat:(NSString *)format;

@end
