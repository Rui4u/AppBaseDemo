//
//  QuestionModel.h
//  AppBaseDemo
//
//  Created by sharui on 2017/9/22.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Questions :NSObject
@property (nonatomic , assign) NSInteger              questionsId;
@property (nonatomic , copy) NSString              * answer;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * question;

@end

@interface QuestionList :NSObject
@property (nonatomic , copy) NSString              * questionListId;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , strong) NSArray<Questions *>              * questions;

@end

@interface QuestionModel :NSObject
@property (nonatomic , strong) NSArray<QuestionList *>              * questionList;

@end
