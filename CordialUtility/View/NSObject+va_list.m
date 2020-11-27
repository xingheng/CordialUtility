//
//  NSObject+va_list.m
//
//  Created by WeiHan on 2/23/16.
//  Copyright © 2016 WeiHan. All rights reserved.
//

#import "NSObject+va_list.h"

@implementation NSObject (va_list)

+ (void)apply:(void (^)(id))block forObjects:(id)firstObject, ...
{
    id eachObject;
    va_list argumentList;

    if (firstObject) {
        // The first argument isn't part of the varargs list, so we'll handle it separately.
        block(firstObject);

        // Start scanning for arguments after firstObject.
        va_start(argumentList, firstObject);

        // As many times as we can get an argument of type "id"
        while ((eachObject = va_arg(argumentList, id)))
            // that isn't nil, add it to self's contents.
            block(eachObject);

        va_end(argumentList);
    }
}

@end
