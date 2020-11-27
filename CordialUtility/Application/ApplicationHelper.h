//
//  ApplicationHelper.h
//
//  Created by WeiHan on 10/30/17.
//  Copyright © 2017 WeiHan. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#endif

#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#endif

#ifndef IsPad
#define IsPad         (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? YES : NO
#endif

BOOL CallPhone(NSString *phoneNum);

BOOL OpenAppSettingURL(void);
