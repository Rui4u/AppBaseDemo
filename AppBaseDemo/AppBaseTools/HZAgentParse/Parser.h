//
//  Parser.h
//  
//
//  Created by Zhentai on 15-2-7.
//  Copyright (c) 2015年 com.yixin.itoumi. All rights reserved.
//  解析网络数据，生成对象

#import <Foundation/Foundation.h>

@interface Parser : NSObject


/**
 *  输入NSString、ClassName生成相应的对象
 *
 *  @param soruceDic 数据源 NSDictionary类型
 *  @param className    转化生成的对象
 *
 *  @return 由ClassName生成的对象
 */
+ (id)  stringTransformObjectWithClassName : (NSDictionary *) soruceDic
                                 className : (NSString *) className;

+ (id)  stringTransformObjectWithClassName : (NSDictionary *) soruceDic
                                 className : (NSString *) className
                                beReplaced : (NSString * ) beReplaced
                                   replace : (NSString * ) replace;

//attribute

/**
 输入字典、ClassName、attributeName（其他属性名）生成对象

 @param soruceDic <#soruceDic description#>
 @param className <#className description#>
 @param attributeName <#attributeName description#>
 @return <#return value description#>
 */
+ (id) stringTransformObjectWithClassName : (NSDictionary *)soruceDic
                                className : (NSString *)className
                            attributeName : (NSString * ) attributeName,... NS_REQUIRES_NIL_TERMINATION ;
//attributeKey : (NSString * ) attributeKey,... NS_REQUIRES_NIL_TERMINATION;






/**
 *  输入NSString、ClassName生成相应的对象数组
 *
 *  @param soruceDic 数据源 NSDictionary类型
 *  @param className    转化生成的对象
 *
 *  @return 由ClassName生成的对象
 */
+ (NSMutableArray * ) stringTansformArrayObjectWithClassName : (NSDictionary *) soruceDic
                                                   className : (NSString *) className;

/**
 *  输入NSString、ClassName生成相应的对象数组 beReplaced:被替换的key; replace :替换的key
 *
 *  @param soruceDic  sourceDic
 *  @param className  <#className description#>
 *  @param beReplaced <#beReplaced description#>
 *  @param replace    <#replace description#>
 *
 *  @return <#return value description#>
 */
+ (NSArray * ) stringTansformArrayObjectWithClassName : (NSDictionary *)sourceDic
                                            className : (NSString * )className
                                           beReplaced : (NSString * ) beReplaced
                                              replace : (NSString * ) replace ;



/**
 *  输入NSString、ClassName,subClassName 生成相应的对象数组
 *
 *  @param soruceDic 数据源 NSDictionary类型
 *  @param className    转化生成的对象
 *  @param subClassName    转化生成包含的对象
 *  @param property    所包含的对象对应的的属性
 *  @return 由ClassName生成的对象
 */
+ (NSArray *) stringTansformArrayObjectWithClassName : (NSDictionary *) sourceDic
                                           className : (NSString *) className
                                          propertyStr: (NSString *) property
                                        subClassName : (NSString *) subName;


/**
 *  输入NSMutableArray、ClassName 生成相应的对象数组
 *
 *  @param array     NSMutableArray
 *  @param className 转化生成的对象
 *
 *  @return NSArray
 */
- (NSArray * )   stringTansformArrayObjectWithArray : (NSMutableArray *) array
                                          className : (NSString * ) className;

/**
 输入NSMutableArray、ClassName 生成相应的对象数组
 
 @param array
 @param className转化生成的对象
 @return
 */
+ (NSArray *)  stringTansformArrayObjectWithDataSourceArray : (NSMutableArray *) array
                                        className : (NSString * ) className;

@end
