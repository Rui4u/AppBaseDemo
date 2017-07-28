//
//  NSString+SRString.m
//  HZPrivateEquityiOSClient
//
//  Created by ZhentaiNing_Huizhong on 16/10/9.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "NSString+SRString.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (SRString)

#pragma mark -

#pragma mark - Public object Method
#pragma mark -
- (NSString *)appNextLineKeyword:(NSString *)word
{
    NSMutableString *temp = [[NSMutableString alloc] init];
    for (int i=0; i<[word length]; i++) {
        [temp appendFormat:@"%@",[word substringWithRange:NSMakeRange(i, 1)]];
        [temp appendFormat:@"\n"];
    }
    return temp;
}
- (NSArray * ) cutCharacterWithString : (NSString * ) string
                            character : (NSString * ) character
{
    NSArray * array = [string  componentsSeparatedByString:character];
    
    return array ;
}

#pragma mark Encryption
- (NSString *)stringFromMD5
{
    if(self == nil || [self length] == 0)
        return nil;
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    return outputString;
}

#pragma mark Encryption
- (NSString*)sha1
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:[self length]];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
    
}
- (BOOL)isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isValidateMobile
{
    //手机号以13，14, 15，18开头，八个 \d 数字字符
//    NSString *phoneRegex = @"^((17[0-9])|(13[0-9])|(14[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
      NSString *phoneRegex = @"^((17[0-9])|(13[0-9])|(14[0-9])|(15[0-9])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    //    BOOL b = [phoneTest evaluateWithObject:mobile];
    return [phoneTest evaluateWithObject:self];
}

- (BOOL)validateCarNo
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}

- (BOOL)isNumber
{
    NSString *carRegex = @"^[0-9]*$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}
/**
 URL Encode
 EscapedInQueryString 使用的AFN里面的 目前接口没有对 + 进行编码.所以会引起签名错误.其他特殊符号暂时不清楚是否进行编码
 */
- (NSString *)URLEncodedStringbj
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, (CFStringRef)@":/?&=;+!@#$()',*", kCFStringEncodingUTF8));
    //
    //    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, (CFStringRef)@"!*’();:@&=+$,/?%#[] ", kCFStringEncodingUTF8));
    
    //    NSString *encodedString = (NSString *)
    //    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
    //                                            (CFStringRef)self,
    //                                            (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
    //                                            NULL,
    //                                            kCFStringEncodingUTF8));
    //    return encodedString;
}
- (NSString*)URLDecodedString
{
    
    return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,(CFStringRef)self, CFSTR(":/?&=;+!@#$()',*"),kCFStringEncodingUTF8));//CFSTR(":/?&=;+!@#$()',*"),kCFStringEncodingUTF8;
}


#pragma mark - 

#pragma mark - Public Class Method
#pragma mark -
+ (id)jsonStringToObject:(NSString *)jsonString
{
    NSData * objData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    id obj = [NSJSONSerialization JSONObjectWithData:objData options:NSJSONReadingMutableContainers error:nil];
    return obj;
}



+ (NSString*)objectTojsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }
    return jsonString;
}

- (CGSize)getSizeOfString:(UIFont *)font constroSize:(CGSize)size
{
    //    CGSize s = [self sizeWithFont:font constrainedToSize:size];
    
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    
    return rect.size;
}

- (CGSize)getSizeOfStringFontSize:(int)fontSize constroSize:(CGSize)size
{
    //    CGSize s = [self sizeWithFont:[UIFont systemFontOfSize:fontSize]
    //               constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGRect rect = [self boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attribute
                                     context:nil];
    return rect.size;
}


+ (NSString * ) timeStringFormServerWithString : (NSString * ) string
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
//    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSDate * date = [dateFormatter dateFromString:[ NSString stringWithFormat:@"%tu",[string longLongValue]/1000 ]];
    
    //    NSDateFormatter* dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
    
}
+ (NSString *)getCurrentDateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    [dateFormatter setDateFormat:@"HH(24制):hh(12制):mm 'on' EEEE MMMM d"];
    NSString * date = [dateFormatter stringFromDate:[NSDate date]];
    NSLog(@"date%@",date);
    return date;
}

+ (NSString *)getCurrentDateStringForXieYue
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"MM/dd HH:mm"];
    //    [dateFormatter setDateFormat:@"HH(24制):hh(12制):mm 'on' EEEE MMMM d"];
    NSString * date = [dateFormatter stringFromDate:[NSDate date]];
    NSLog(@"date%@",date);
    return date;
}

+ (NSString *)dateToStringMMDDHHMMForXie:(NSDate *)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"MM/dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+ (NSString *)dateToStringYYYYMMDDHHMMForXie:(NSDate *)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}
+ (NSString * ) dateToStringYYYYMMDDHHMMSSForDate : (NSDate * )date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}
+ (NSString *)getTimerIntervalSince1970
{
    
    NSString * timeIntervalSince1970 = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
    return timeIntervalSince1970;
}

+ (NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+ (NSString *)dateToStringYYYMMDDHHMM:(NSDate *)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}
+ (NSString * ) timeYMDHMToYMDHSSForTimeString : (NSString * ) timeString
{
    
    return nil ;
}
#pragma mark - 密码正则  至少6位  由数字和字母组成
+ (BOOL) validatePassword:(NSString *)password
{
    BOOL flag;
    if (password.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,18}$";
    NSPredicate *passwordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [passwordPredicate evaluateWithObject:password];
}

//身份证正则表达式
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
/**
 *  判断是否为空 nil
 *
 *  @param aKey <#aKey description#>
 *
 *  @return <#return value description#>
 */
- (id)noNullobjectForKey:(id)aKey
{
    NSString *str=[self valueForKey:aKey];
    if (str==nil||[str isKindOfClass:[NSNull class]]||[str isEqual:[NSNull null]])
    {
        str=@"";
    }
    return str;
}
+ (BOOL) isHavingRecently18WithIDCardNummber : (NSString * ) IDCardNumber
                                matchingTime : (NSString * ) matchingTime
{
    NSString * cardNumber =  [IDCardNumber copy];
    NSString * matchTime  =  [matchingTime copy];//年
    if (cardNumber.length == 15)
    {
        cardNumber = [cardNumber substringWithRange:NSMakeRange(6, 2)];//15位身份证号出生年月
        cardNumber = [NSString stringWithFormat:@"19%@",cardNumber];
    }
    else if(cardNumber.length == 18)
    {
        cardNumber = [cardNumber substringWithRange:NSMakeRange(6 ,4)];
    }
    if(([matchTime integerValue] - [cardNumber integerValue]) >= 18)
    {
        return YES ;//满18岁
    }
    return NO ;
    
 
    
    return YES ;
}
+ (BOOL) isNumberWithString : (NSString * ) inputString
{
    NSString * regex        = @"^[0-9]*$";
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch            = [pred evaluateWithObject:inputString];
    if (isMatch)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
+ (BOOL) isBaiNumberWithString : (NSString * ) inputString
{
    if( ([inputString integerValue]/(double)100) > ([inputString integerValue]/100) )
    {
        //如果true 证明 i不能被100整除
        return NO;
    }else{
        //能被100整除
        return YES;
    }
}
@end
