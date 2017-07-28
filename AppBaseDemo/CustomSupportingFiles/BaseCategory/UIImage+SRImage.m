//
//  UIImage+SRImage.m
//    SRiOSClient
//
//  Created by sharui on 2017/2/22.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "UIImage+SRImage.h"

@implementation UIImage (SRImage)
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
