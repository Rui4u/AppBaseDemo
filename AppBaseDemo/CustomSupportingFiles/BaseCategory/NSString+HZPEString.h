//
//  NSString+HZPEString.h
//  HZPrivateEquityiOSClient
//
//  Created by ZhentaiNing_Huizhong on 16/10/9.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  汇中 世泽 String 类目
 */
@interface NSString (HZPEString)

#pragma mark - Public object method
/*字符串转 MD5*/
- (NSString *)stringFromMD5;
/*字符串转 sha1*/
- (NSString *)sha1;
/*字符加换行符号\n*/
- (NSString *)appNextLineKeyword:(NSString *)word;
/**
 字符按照特殊字符切割后生产新的String
 
 @param string <#string description#>
 @param character <#character description#>
 @return <#return value description#>
 */
- (NSArray * ) cutCharacterWithString : (NSString * ) string
                            character : (NSString * ) character ;

/*获取字符串的长度*/
- (CGSize)getSizeOfStringFontSize:(int)fontSize constroSize:(CGSize)size;
- (CGSize)getSizeOfString:(UIFont *)font constroSize:(CGSize)size;

/*邮箱验证 MODIFIED BY HELENSONG*/
- (BOOL)isValidateEmail;
/*手机号码验证 MODIFIED BY HELENSONG*/
- (BOOL)isValidateMobile;
/*车牌号验证 MODIFIED BY HELENSONG*/
- (BOOL)validateCarNo;
/*数字验证 MODIFIED BY HELENSONG*/
- (BOOL)isNumber;
//汉字编码
-(NSString *)URLEncodedStringbj;
-(NSString*)URLDecodedString;
/**
 *  判断是否为空 nil
 *
 *  @param aKey <#aKey description#>
 *
 *  @return <#return value description#>
 */
- (id)noNullobjectForKey:(id)aKey ;

#pragma mark -  Public Class Method
/* NSArray or NSDitionary to JsonString */
+ (NSString *)objectTojsonString:(id)object;
+ (id)jsonStringToObject:(NSString *)jsonString;



//获取当前的时间字符串
+ (NSString *)getCurrentDateString;

+ (NSString *)getTimerIntervalSince1970;

+ (NSString *)dateToStringMMDDHHMMForXie:(NSDate *)date;

+ (NSString *)dateToStringYYYYMMDDHHMMForXie:(NSDate *)date;

+ (NSString *)getCurrentDateStringForXieYue;

//NSDate 转 NSString
+ (NSString *)dateToString:(NSDate *)date;
//yyyy-MM-dd HH:mm
+ (NSString *)dateToStringYYYMMDDHHMM:(NSDate *)date;
/**
 *  年月日时分秒
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
+ (NSString * ) dateToStringYYYYMMDDHHMMSSForDate : (NSDate * )date ;

/**
 *  yyyy/mm/dd HH:MM 转换成yyyy-mm-dd HH:MM格式
 *
 *  @param string <#string description#>
 *
 *  @return <#return value description#>
 */
+ (NSString * ) timeStringFormServerWithString : (NSString * ) string ;
/**
 *  年月日时分格式时间转换成年月日时分秒的格式
 *
 *  @param timeString <#timeString description#>
 *
 *  @return <#return value description#>
 */
+ (NSString * ) timeYMDHMToYMDHSSForTimeString : (NSString * ) timeString ;


//身份证正则
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

/**
 *  依据输入的身份证号和比对时间，判断用户是否满18岁 满18岁：返回YES;不满18岁：返回NO;
 *
 *  @param IDCardNumber <#IDCardNumber description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL) isHavingRecently18WithIDCardNummber : (NSString * ) IDCardNumber
                                matchingTime : (NSString * ) matchingTime;

//密码正则
+ (BOOL) validatePassword:(NSString *)password;

/**
 校验是否为纯数字

 @param inputString <#inputString description#>
 @return <#return value description#>
 */
+ (BOOL) isNumberWithString : (NSString * ) inputString ;

/**
校验是否为100 的整数倍

 @param inputString <#inputString description#>
 @return <#return value description#>
 */
+ (BOOL) isBaiNumberWithString : (NSString * ) inputString;

@end
