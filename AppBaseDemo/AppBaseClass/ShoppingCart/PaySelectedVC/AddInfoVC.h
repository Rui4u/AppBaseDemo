//
//  AddInfoVC.h
//  GPhoneFlowiOSClient
//
//  Created by Livia on 16/9/12.
//  Copyright © 2016年 ZhentaiNing. All rights reserved.
//

#import "BaseViewController.h"

@protocol AddInfoVCDelgate <NSObject>
/**
 *  代理方法
 *
 *  @param userName      用户名
 *  @param accountNumber 账号
 */
- (void) bringUserName:(NSString *)userName accountNumber:(NSString *)accountNumber;

@end

/// 添加信息控制器
@interface AddInfoVC : BaseViewController

@property (nonatomic , weak) id<AddInfoVCDelgate>delegate;

@end
