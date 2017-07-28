//
//  NSMutableAttributedString+SRSpecial.h
//  HZPrivateEquityiOSClient
//
//  Created by sharui on 16/10/10.
//  Copyright © 2016年 sharui. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *       针对 字符特殊处理
 */
@interface NSMutableAttributedString (SRSpecial)

/**
 *  根据输入的String 输出两段颜色不同的 字符
 *
 *  @param txt    <#txt description#>
 *  @param font   <#font description#>
 *  @param color  <#color description#>
 *  @param scolor <#scolor description#>
 *  @param font2  <#font2 description#>
 *
 *  @return <#return value description#>
 */
+ (NSMutableAttributedString *)setAttributeString : (NSString *)txt
                                             font : (CGFloat)font
                                        textcolor : (UIColor*)color
                                      secondcolor : (UIColor*)scolor
                                       secondfont : (CGFloat)font2 ;



/**
 多个变色 

 @param txt <#txt description#>
 @param font <#font description#>
 @param color <#color description#>
 @param scolor <#scolor description#>
 @param font2 <#font2 description#>
 @return <#return value description#>
 */
+ (NSMutableAttributedString *)setMoreAttributeString : (NSString *)txt
                                                 font : (CGFloat)font
                                            textcolor : (UIColor*)color
                                          secondcolor : (UIColor*)scolor
                                           secondfont : (CGFloat)font2;
@end
