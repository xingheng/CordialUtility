//
//  ApplicationHelper.h
//
//  Created by WeiHan on 10/30/17.
//  Copyright © 2017 WeiHan. All rights reserved.
//

#import "ApplicationHelper.h"

// http://stackoverflow.com/a/33393195/1677041
BOOL CallPhone(NSString *phone)
{
    NSCParameterAssert(phone.length > 0);

    NSURL *urlOption1 = [NSURL URLWithString:[@"telprompt://" stringByAppendingString:phone]];
    NSURL *urlOption2 = [NSURL URLWithString:[@"tel://" stringByAppendingString:phone]];
    NSURL *targetURL = nil;

    if ([UIApplication.sharedApplication canOpenURL:urlOption1]) {
        targetURL = urlOption1;
    } else if ([UIApplication.sharedApplication canOpenURL:urlOption2]) {
        targetURL = urlOption2;
    }

    if (targetURL) {
        if (@available(iOS 10.0, *)) {
            [UIApplication.sharedApplication openURL:targetURL options:@{} completionHandler:nil];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            [UIApplication.sharedApplication openURL:targetURL];
#pragma clang diagnostic pop
        }
    } else {
        return NO;
    }

    return YES;
}

BOOL OpenAppSettingURL(void)
{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    UIApplication *application = [UIApplication sharedApplication];

    if ([application canOpenURL:url]) {
        if (@available(iOS 10.0, *)) {
            [UIApplication.sharedApplication openURL:url options:@{} completionHandler:nil];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            [UIApplication.sharedApplication openURL:url];
#pragma clang diagnostic pop
        }
    }

    return NO;
}
