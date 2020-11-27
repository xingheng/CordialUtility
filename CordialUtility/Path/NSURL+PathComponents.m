//
//  NSURL+PathComponents.m
//
//  Created by WeiHan on 11/22/16.
//  Copyright © 2016 WeiHan. All rights reserved.
//

#import "NSURL+PathComponents.h"

#pragma mark - Functions

//
// This function is completely copyied from AFNetworking.
// Path: https://github.com/AFNetworking/AFNetworking/blob/master/AFNetworking/AFURLRequestSerialization.m
// Wei Han.
//
// -------------------------------------------- BEGIN --------------------------------------------
/**
   Returns a percent-escaped string following RFC 3986 for a query string key or value.
   RFC 3986 states that the following characters are "reserved" characters.
   - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
   - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="

   In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
   query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
   should be percent-escaped in the query string.
   - parameter string: The string to be percent-escaped.
   - returns: The percent-escaped string.
 */
static NSString * GetHTTPPercentEscapedStringFromString(NSString *string)
{
    static NSString *const kAFCharactersGeneralDelimitersToEncode = @":#[]@";  // does not include "?" or "/" due to RFC 3986 - Section 3.4
    static NSString *const kAFCharactersSubDelimitersToEncode = @"!$&'()*+,;=";

    NSMutableCharacterSet *allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];

    [allowedCharacterSet removeCharactersInString:[kAFCharactersGeneralDelimitersToEncode stringByAppendingString:kAFCharactersSubDelimitersToEncode]];

    // FIXME: https://github.com/AFNetworking/AFNetworking/pull/3028
    // return [string stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];

    static NSUInteger const batchSize = 50;

    NSUInteger index = 0;
    NSMutableString *escaped = @"".mutableCopy;

    while (index < string.length) {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wgnu"
        NSUInteger length = MIN(string.length - index, batchSize);
#pragma GCC diagnostic pop
        NSRange range = NSMakeRange(index, length);

        // To avoid breaking up character sequences such as 👴🏻👮🏽
        range = [string rangeOfComposedCharacterSequencesForRange:range];

        NSString *substring = [string substringWithRange:range];
        NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
        [escaped appendString:encoded];

        index += range.length;
    }

    return escaped;
}

// --------------------------------------------- END ---------------------------------------------

static NSURL * GetEncodedURLFromURLQueryItems(NSURL *sourceURL, NSArray<NSURLQueryItem *> *queryItems)
{
#if 0
    // BUG: The NSURLComponents concatenates the query items with [NSCharacterSet URLQueryAllowedCharacterSet]
    //  charset, it differ from RFC 3986 rule.
    // BACKGROUND: To keep the same rule with other platforms (Android, etc), let's use the same allowed chartset
    //  from AFNetworking.

    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:sourceURL resolvingAgainstBaseURL:NO];

    components.queryItems = queryItems.count > 0 ? queryItems : nil;
    return components.URL;

#else

    if (!sourceURL || queryItems.count <= 0) {
        return sourceURL;
    }

    NSString *strURL = sourceURL.absoluteString;
    NSUInteger index = [strURL rangeOfString:@"?"].location;

    if (index == NSNotFound) {
        strURL = [strURL stringByAppendingString:@"?"];
    } else {
        strURL = [strURL substringToIndex:index + 1];
    }

    NSMutableArray<NSString *> *arrQueryItem = [[NSMutableArray alloc] initWithCapacity:queryItems.count];

    for (NSURLQueryItem *item in queryItems) {
        [arrQueryItem addObject:[NSString stringWithFormat:@"%@=%@", GetHTTPPercentEscapedStringFromString(item.name), GetHTTPPercentEscapedStringFromString(item.value)]];
    }

    strURL = [strURL stringByAppendingString:[arrQueryItem componentsJoinedByString:@"&"]];

    return [NSURL URLWithString:strURL];

#endif // if 0
}

#pragma mark - NSURL (PathComponents)

@implementation NSURL (PathComponents)

- (NSURL *)URLByAppendingQueryPathComponent:(NSDictionary<NSString *, NSString *> *)dictComponent
{
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:self resolvingAgainstBaseURL:NO];

    NSMutableArray<NSURLQueryItem *> *queryItems = [[NSMutableArray alloc] initWithArray:components.queryItems];

    for (NSString *keyItem in [dictComponent allKeys]) {
        NSString *valueItem = dictComponent[keyItem];
        __block NSUInteger index = NSNotFound;

        [queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem *obj, NSUInteger idx, BOOL *stop) {
            if ([keyItem isEqualToString:obj.name]) {
                index = idx;
                *stop = YES;
            }
        }];

        if (index != NSNotFound) {
            [queryItems removeObjectAtIndex:index];
        }

        NSURLQueryItem *newQueryItem = [NSURLQueryItem queryItemWithName:keyItem value:valueItem];

        [queryItems addObject:newQueryItem];
    }

    return GetEncodedURLFromURLQueryItems(self, queryItems);
}

- (NSURL *)URLByDeletingQueryPathComponent:(NSArray<NSString *> *)arrQueryComponent
{
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:self resolvingAgainstBaseURL:NO];

    NSMutableArray<NSURLQueryItem *> *queryItems = [[NSMutableArray alloc] initWithArray:components.queryItems];

    for (NSString *keyItem in arrQueryComponent) {
        __block NSUInteger index = NSNotFound;

        [queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem *obj, NSUInteger idx, BOOL *stop) {
            if ([keyItem isEqualToString:obj.name]) {
                index = idx;
                *stop = YES;
            }
        }];

        if (index != NSNotFound) {
            [queryItems removeObjectAtIndex:index];
        }
    }

    return GetEncodedURLFromURLQueryItems(self, queryItems);
}

@end
