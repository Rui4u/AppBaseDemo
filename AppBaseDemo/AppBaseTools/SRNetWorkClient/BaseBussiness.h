//
//  BaseBussiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/2.
//  Copyright © 2017年 sharui. All rights reserved.
//


#ifndef BaseBussiness_h
#define BaseBussiness_h




#endif /* BaseBussiness_h */



#define kHTTP_HOST_URL  @"http://47.92.117.38:8088"


//注册
#define kRegisterBusinessUrl                 [NSString stringWithFormat :@"%@//gs/store/insert?",kHTTP_HOST_URL]
#define kLoginBusinessUrl                 [NSString stringWithFormat :@"%@//gs/store/login?",kHTTP_HOST_URL]


NS_ASSUME_NONNULL_BEGIN
typedef void (^netWorkFailBlock)(NSString * netWorkMeeage);

typedef void (^netWorkSuccBlock) (BOOL  succBlock);


/**
 *  世泽 网络业务 层 基础类
 */
@interface BaseBussiness : NSObject

@property (nonatomic , strong) NSDictionary * bodyDic ;
+(NSString * ) netWorkFailWithErroe : (NSError * )error;



+ (void) netWorkSucceed200WithDir : (NSDictionary * ) dir
					 succeedBlock : (netWorkSuccBlock) succeedBlock ;

- (instancetype) init UNAVAILABLE_ATTRIBUTE ;

+ (instancetype) new UNAVAILABLE_ATTRIBUTE ;


@end
NS_ASSUME_NONNULL_END
