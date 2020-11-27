//
//  NSString+Device.h
//
//  Created by WeiHan on 2018/10/23.
//

#import <Foundation/Foundation.h>

NSString * GetDeviceModel(void);

BOOL IsiPhoneX(void);

BOOL IsNotchiPhone(void);


@interface NSString (Device)

+ (NSString *)deviceModel;

@end
