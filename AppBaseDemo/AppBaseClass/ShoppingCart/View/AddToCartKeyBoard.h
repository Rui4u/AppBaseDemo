//
//  AddToCartKeyBoard.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/13.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddToCartKeyBoard : UIView

/**
 点击确定回调
 */
@property (nonatomic ,copy) void(^sureBoardBlack)(NSString * num);
@end
