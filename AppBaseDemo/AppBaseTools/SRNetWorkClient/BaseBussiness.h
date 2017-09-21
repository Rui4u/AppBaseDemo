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
//修改密码
#define KUpdatePwdBussinessUrl                 [NSString stringWithFormat :@"%@/gs/store/updatePwd?",kHTTP_HOST_URL]

//开通城市列表
#define kCityListBusinessUrl                 [NSString stringWithFormat :@"%@/gs/city/listAPI?",kHTTP_HOST_URL]
//完善用户信息
#define KStoreInfoBussinessUrl            [NSString stringWithFormat :@"%@/gs/store/update?",kHTTP_HOST_URL]
//短信接口
#define KSendVCodeUpdateBussinessUrl            [NSString stringWithFormat :@"%@/gs/store/sendVCodeUpdate?",kHTTP_HOST_URL]

//验证接口
#define KVerifyCodeTelUpdateBussinessUrl            [NSString stringWithFormat :@"%@/gs/store/verifyCodeTelUpdate?",kHTTP_HOST_URL]


//首页
#define KHomeBussinessUrl            [NSString stringWithFormat :@"%@/gs/index/indexList?",kHTTP_HOST_URL]
//全部商品
#define KGoodslistAllBussinessUrl            [NSString stringWithFormat :@"%@/gs/goods/goodslistAll?",kHTTP_HOST_URL]
//选择类目商品
#define kSelectGoodsListlBussinessUrl            [NSString stringWithFormat :@"%@/gs/goods/selectGoodsList?",kHTTP_HOST_URL]
//选择类目商品
#define kProductDetailBussinessUrl            [NSString stringWithFormat :@"%@/gs/goods/selectGoods?",kHTTP_HOST_URL]

//搜索
#define kSearchGoodsListlBussinessUrl            [NSString stringWithFormat :@"%@/gs/goods/selectGoodsByName?",kHTTP_HOST_URL]

//修改购物车个数
#define kAddCarBussinessUrl            [NSString stringWithFormat :@"%@/gs/shopCar/addCar?",kHTTP_HOST_URL]
//删除购物车
#define kDleteCarBussinessUrl            [NSString stringWithFormat :@"%@/gs/shopCar/deleteCar?",kHTTP_HOST_URL]
//添加清单
#define kProductAddListBussinessUrl  [NSString stringWithFormat :@"%@/gs/store/addList?",kHTTP_HOST_URL]
//移除清单
#define kProductRemoveListBussinessUrl [NSString stringWithFormat :@"%@/gs/store/removeList?",kHTTP_HOST_URL]
//购物车列表
#define kShopCarListBussinessUrl [NSString stringWithFormat :@"%@/gs/shopCar/selectCar?",kHTTP_HOST_URL]
//获取价格
#define kCountPriceBussinessUrl [NSString stringWithFormat :@"%@/gs/shopCar/countPrice?",kHTTP_HOST_URL]


#define kQuestionBussinessUrl [NSString stringWithFormat :@"%@/gs/question/listAPI?",kHTTP_HOST_URL]
//我的发票
#define kCommonToolsInvoiceBussinessUrl [NSString stringWithFormat :@"%@/gs/commonTools/invoice?",kHTTP_HOST_URL]
//新品需求需要的菜品
#define kCommonToolsCategoryBussinessUrl [NSString stringWithFormat :@"%@/gs/commonTools/category?",kHTTP_HOST_URL]

//新品需求需要的菜品保存
#define kQuickFeedbackBussinessUrl [NSString stringWithFormat :@"%@/gs/commonTools/quickFeedback?",kHTTP_HOST_URL]



//订单列表
#define kOrderListBussinessUrl [NSString stringWithFormat :@"%@/gs/orderAPI/list?",kHTTP_HOST_URL]
//订单列表
#define kOrderDetailBussinessUrl [NSString stringWithFormat :@"%@/gs/orderAPI/show?",kHTTP_HOST_URL]
//填写订单
#define kFillOrderBussinessUrl [NSString stringWithFormat :@"%@/gs/orderAPI/submitOrder?",kHTTP_HOST_URL]
//下单
#define kDoOrderBussinessUrl [NSString stringWithFormat :@"%@/gs/orderAPI/buildOrder?",kHTTP_HOST_URL]
//取消订单
#define kCancelOrderBussinessUrl [NSString stringWithFormat :@"%@/gs/orderAPI/cancelOrder?",kHTTP_HOST_URL]

//微信
#define kExecuteWXPayBussinessUrl [NSString stringWithFormat :@"%@/gs/config/pay?",kHTTP_HOST_URL]
//支付宝
#define kExecuteAliPayBussinessUrl [NSString stringWithFormat :@"%@/gs/config/getOrder?",kHTTP_HOST_URL]

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
