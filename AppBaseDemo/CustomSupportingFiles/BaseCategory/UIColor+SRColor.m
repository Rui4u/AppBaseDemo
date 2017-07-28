//
//  UIColor+SRColor.m
//  HZPrivateEquityiOSClient
//
//  Created by ZhentaiNing_Huizhong on 16/10/9.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "UIColor+SRColor.h"

@implementation UIColor (SRColor)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert WithFloat:(CGFloat)colorFloat
{
    if ([stringToConvert hasPrefix:@"#"]) {
        stringToConvert = [stringToConvert substringFromIndex:1];
    }
    
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    
    if (![scanner scanHexInt:&hexNum]) {
        return nil;
    }
    
    return [UIColor colorWithRGBHex:hexNum withFloat:colorFloat];

}



+ (UIColor *)colorWithRGBHex:(UInt32)hex withFloat:(CGFloat)colorFloat
{
    
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:colorFloat];
}




+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    if ([stringToConvert hasPrefix:@"#"]) {
        stringToConvert = [stringToConvert substringFromIndex:1];
    }
    
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    
    if (![scanner scanHexInt:&hexNum]) {
        return nil;
    }
    
    return [UIColor colorWithRGBHex:hexNum];
}
+ (UIColor *)colorWithRGBHex:(UInt32)hex
{
    
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}


@end
