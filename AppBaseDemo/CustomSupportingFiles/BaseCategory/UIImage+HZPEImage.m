//
//  UIImage+HZPEImage.m
//  HZAgentiOSClient
//
//  Created by sharui on 2017/2/22.
//  Copyright © 2017年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "UIImage+HZPEImage.h"

@implementation UIImage (HZPEImage)
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
@end
