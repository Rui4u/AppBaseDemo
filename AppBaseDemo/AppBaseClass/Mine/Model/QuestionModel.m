//
//  QuestionModel.m
//  AppBaseDemo
//
//  Created by sharui on 2017/9/22.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "QuestionModel.h"

@implementation Questions
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"questionsId" : @"id"};
}
@end
@implementation QuestionList
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"questionListId" : @"id"};
}

+ (NSDictionary *)objectClassInArray{
    return @{
             @"questions":@"Questions",
             };
}


@end
@implementation QuestionModel

+ (NSDictionary *)objectClassInArray{
    return @{
             @"questionList":@"QuestionList",
             };
}
@end

