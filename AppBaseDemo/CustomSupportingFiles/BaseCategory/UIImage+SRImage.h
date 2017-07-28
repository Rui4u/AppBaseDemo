//
//  UIImage+SRImage.h
//    SRiOSClient
//
//  Created by sharui on 2017/2/22.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SRImage)

/**
 根据颜色获取照片

 @param color <#color description#>
 @param size <#size description#>
 @return <#return value description#>
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
@end
