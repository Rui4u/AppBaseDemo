//
//  QuestionBussiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"
@class QuestionModel;


typedef void (^QuestionSuccessBlock)(QuestionModel* succeed);
typedef void (^QuestionFailBlock) (NSString * failMessage);
typedef void (^QuestionErrorBlcok)(NSString * netWorkErrorMessage);

/**

 */
@interface QuestionBussiness : BaseBussiness

/**
 问题
 
 */
 + (void) requestQuestionWithToken : (NSString* ) token
		  completionSuccessHandler : (QuestionSuccessBlock) completionHandler
			 completionFailHandler : (QuestionFailBlock) completionFailHandler
				   completionError : (QuestionErrorBlcok) completionError;

@end

