//
//  SRCustomDataPicker.h
//  HZAgentiOSClient
//
//  Created by sharui on 2017/6/10.
//  Copyright © 2017年 ZhentaiNing_Huizhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewProductDemandModel.h"
@interface SRCustomDataPicker : UIView

/**
 数据源二维数组
 */
@property (nonatomic ,strong ) NSArray <NSArray <NewProductDemandModel *>*>* dataSourse;
- (void)showDataPicker;
- (void)relodeData;
@property (nonatomic ,strong ) void(^selectCategory)(NewProductDemandModel *model);
@end
