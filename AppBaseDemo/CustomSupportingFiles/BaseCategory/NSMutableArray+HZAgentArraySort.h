//
//  NSMutableArray+HZAgentArraySort.h
//  HZAgentiOSClient
//
//  Created by ZhentaiNing_Huizhong on 16/11/10.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  汇中 世泽 array 元素排序
 */
@interface NSMutableArray (HZAgentArraySort)


/**
 *  依据MutableArray数据源、排序的关键key,对数据源sourceArray排序
 *
 *  @param sourceArray <#sourceArray description#>
 *  @param key         <#key description#>
 *  @param ascending   YES:升序;NO：降序
 *  @param cmptr       <#cmptr description#>
 *
 *  @return <#return value description#>
 */
+ (NSMutableArray * ) sortDescriptorWithSourceArray : ( NSMutableArray * ) sourceArray
                                                key : ( NSString *)key
                                          ascending : (BOOL)ascending
                                         comparator : (NSComparator)cmptr ;

+ (void)sortDescriptorWithSourceArray : ( NSMutableArray ** ) sourceArray
                                  key : ( NSString *)key
                            ascending : (BOOL)ascending ;


@end
