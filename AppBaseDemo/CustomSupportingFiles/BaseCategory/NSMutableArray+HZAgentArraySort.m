//
//  NSMutableArray+HZAgentArraySort.m
//  HZAgentiOSClient
//
//  Created by ZhentaiNing_Huizhong on 16/11/10.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "NSMutableArray+HZAgentArraySort.h"

@implementation NSMutableArray (HZAgentArraySort)

+ (NSMutableArray * ) sortDescriptorWithSourceArray : (nonnull NSMutableArray * ) sourceArray
                                                key : (nullable NSString *)key
                                          ascending : (BOOL)ascending
                                         comparator : (NSComparator)cmptr
{
    
    NSSortDescriptor *distanceDescriptor = [[NSSortDescriptor alloc] initWithKey:key
                                                                       ascending:ascending];
    NSArray *descriptors = [NSArray arrayWithObjects:distanceDescriptor,nil];
    [sourceArray sortUsingDescriptors:descriptors];
////    assert(sourceArray);
//    NSSortDescriptor * distanceDescriptor = [[NSSortDescriptor alloc] initWithKey:key
//                                                                        ascending:ascending];
//    NSArray *descriptors = [NSArray arrayWithObjects:distanceDescriptor,nil];
////    sourceArray =[sourceArray sortUsingDescriptors:descriptors];
//    NSMutableArray * array = [sourceArray sortUsingDescriptors:descriptors];
    return nil;
    
}

+ (void)sortDescriptorWithSourceArray : ( NSMutableArray ** ) sourceArray
                                  key : ( NSString *)key
                            ascending : (BOOL)ascending
{
    NSSortDescriptor *distanceDescriptor = [[NSSortDescriptor alloc] initWithKey:key
                                                                       ascending:ascending];
    NSArray *descriptors = [NSArray arrayWithObjects:distanceDescriptor,nil];
    [(*sourceArray) sortUsingDescriptors:descriptors];
}
@end
