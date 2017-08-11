//
//  BaseBussiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/2.
//  Copyright © 2017年 sharui. All rights reserved.
//


#import <Foundation/Foundation.h>




#define kHTTP_HOST_URL  @"http://47.92.117.38:8088"


//注册
#define kRegisterBusinessUrl                 [NSString stringWithFormat :@"%@/gs/store/insert?",kHTTP_HOST_URL]
//登录
#define kLoginBusinessUrl                 [NSString stringWithFormat :@"%@/gs/store/login?",kHTTP_HOST_URL]
//开通城市列表
#define kCityListBusinessUrl                 [NSString stringWithFormat :@"%@/gs/city/listAPI?",kHTTP_HOST_URL]
//完善用户信息
#define KStoreInfoBussinessUrl            [NSString stringWithFormat :@"%@/gs/store/update?",kHTTP_HOST_URL]


//首页
#define KHomeBussinessUrl            [NSString stringWithFormat :@"%@/gs/index/indexList?",kHTTP_HOST_URL]
//全部商品
#define KGoodslistAllBussinessUrl            [NSString stringWithFormat :@"%@/gs/goods/goodslistAll?",kHTTP_HOST_URL]
//选择类目商品
#define kSelectGoodsListlBussinessUrl            [NSString stringWithFormat :@"%@/gs/goods/selectGoodsList?",kHTTP_HOST_URL]


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
