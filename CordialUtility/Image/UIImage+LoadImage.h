//
//  UIImage+LoadImage.h
//
//  Created by WeiHan on 12/28/16.
//

#import <UIKit/UIKit.h>

NS_INLINE UIImage * LoadImage(NSString *asset)
{
    return [UIImage imageNamed:asset];
}

NS_INLINE UIImage *OriginalImage(NSString *asset)
{
    return [LoadImage(asset) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

NS_INLINE UIImage *TemplateImage(NSString *asset)
{
    return [LoadImage(asset) imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

#ifndef LOADIMAGE
    #define LOADIMAGE(__asset_name__)     LoadImage((__asset_name__))
#endif

UIImage * LoadImageFromBundle(NSString *image, NSString *bundleName);

@interface UIImage (LoadImage)

+ (instancetype)imageNamed:(NSString *)image inBundle:(NSBundle *)bundle;

@end
