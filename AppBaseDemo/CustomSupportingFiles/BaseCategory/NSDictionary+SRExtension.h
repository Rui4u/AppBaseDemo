//
//  NSDictionary+SRExtension.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/3.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SRExtension)

/**
 json 转字典

 @param jsonString <#jsonString description#>
 @return <#return value description#>
 */
+(NSDictionary *) translateDictionaryForjsonString:(NSString *)jsonString;
@end
