//
//  MyInvoiceBussiness.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "BaseBussiness.h"
@class MyInvoiceModel;


typedef void (^MyInvoiceSuccessBlock)(BOOL succeed);
typedef void (^MyInvoiceFailBlock) (NSString * failMessage);
typedef void (^MyInvoiceErrorBlcok)(NSString * netWorkErrorMessage);

/**
 我的发票
 */
@interface MyInvoiceBussiness : BaseBussiness

/**
 我的发票


 @param token <#token description#>
 @param type 发票类型 0 电子普通发票，1普通发票，2专用发票
 @param start 发票抬头
 @param taxpayerId 纳税人识别号
 @param regAddres 注册地址
 @param regPhone 注册电话
 @param telphone 手机号
 @param account 银行账号
 @param addTime 开票时间
 @param startTime 首次开票起始日
 @param mail 邮箱
 @param completionHandler <#completionHandler description#>
 @param completionFailHandler <#completionFailHandler description#>
 @param completionError <#completionError description#>
 */
+ (void) requestMyInvoiceWithToken : (NSString* ) token
							   type:(NSString *)type
							  start:(NSString *)start
							   taxpayerId:(NSString *)taxpayerId
							  regAddres:(NSString *)regAddres
							   regPhone:(NSString *)regPhone
							  telphone:(NSString *)telphone
						   account:(NSString *)account
							  addTime:(NSString *)addTime
							startTime:(NSString *)startTime
							mail:(NSString *)mail
				 completionSuccessHandler : (MyInvoiceSuccessBlock) completionHandler
					completionFailHandler : (MyInvoiceFailBlock) completionFailHandler
					completionError : (MyInvoiceErrorBlcok) completionError;


@end
