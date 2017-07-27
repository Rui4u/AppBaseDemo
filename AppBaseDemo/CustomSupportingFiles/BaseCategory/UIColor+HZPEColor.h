//
//  UIColor+HZPEColor.h
//  HZPrivateEquityiOSClient
//
//  Created by ZhentaiNing_Huizhong on 16/10/9.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  汇中 UIColor 类目
 */
@interface UIColor (HZPEColor)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert ;


/**
 <#Description#>

 @param stringToConvert <#stringToConvert description#>
 @param colorFloat      透明度

 @return <#return value description#>
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert  WithFloat:(CGFloat)colorFloat;
@end
