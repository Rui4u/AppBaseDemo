//
//  NSString+HZPEDoc.h
//  HZPrivateEquityiOSClient
//
//  Created by ZhentaiNing_Huizhong on 16/10/26.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HZPEDoc)
+(NSString *)documentPath;
+(NSString *)cachePath;
+(NSString *)formatCurDate;
+(NSString *)formatCurDay;
+(NSString *)getAppVer;
- (NSString*)removeAllSpace;
- (NSURL *) toURL;
- (BOOL) isEmail;
- (BOOL) isEmpty;
- (NSString *) escapeHTML;
- (NSString *) unescapeHTML;
- (NSString *) stringByRemovingHTML;
- (NSString *) MD5;
- (NSString * )URLEncode;
-(NSString *)trim;

-(BOOL) isOlderVersionThan:(NSString*)otherVersion;
-(BOOL) isNewerVersionThan:(NSString*)otherVersion;
/**
 字符串加入千分号保留两位
 
 @param perStr <#perStr description#>
 @return <#return value description#>
 */
+ (NSString *)insertPermilWithStr:(NSString *)perStr;

/**
 字符串加入千分号

 @param perStr <#perStr description#>
 @return <#return value description#>
 */
+ (NSString *)changeDigitalMicrometerWithStr:(NSString *)perStr;


/**
 千分号转无千分号

 @param perStr <#perStr description#>
 @return <#return value description#>
 */
+ (NSString *)changePermilToNomal:(NSString *)perStr;

@end
