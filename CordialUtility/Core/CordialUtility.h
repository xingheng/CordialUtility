//
//  CordialUtility.h
//  CordialUtility
//
//  Created by WeiHan on 12/16/16.
//  Copyright © 2016 Wei Han. All rights reserved.
//

#ifndef CordialUtility_h
#define CordialUtility_h

// ------------------- Functions -------------------

#ifdef __cplusplus
extern "C" {
#endif

static inline BOOL IsNull(id value)
{
    return !value || [value isEqual:[NSNull null]];
}

static inline BOOL IsNullString(NSString *string)
{
    return IsNull(string) || [string isEqualToString:@""];
}

static inline id ValueForKey(NSDictionary *dict, NSString *key)
{
    if ([dict.allKeys containsObject:key]) {
        id value = dict[key];
        return IsNull(value) ? nil : value;
    }

    return nil;
}

#ifdef __cplusplus
}
#endif

#endif /* CordialUtility_h */
