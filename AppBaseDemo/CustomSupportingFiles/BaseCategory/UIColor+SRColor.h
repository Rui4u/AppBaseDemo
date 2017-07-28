//
//  UIColor+SRColor.h
//  HZPrivateEquityiOSClient
//
//  Created by sharui on 16/10/9.
//  Copyright © 2016年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *    UIColor 类目
 */
@interface UIColor (SRColor)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert ;


/**
 <#Description#>

 @param stringToConvert <#stringToConvert description#>
 @param colorFloat      透明度

 @return <#return value description#>
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert  WithFloat:(CGFloat)colorFloat;
+ (UIColor *)randomOfColor;
@end
