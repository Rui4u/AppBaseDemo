//
//  CustomViewController.h
//  HZAgentiOSClient
//
//  Created by sharui on 2016/11/10.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


/**
 用于上滑吸附
 */
@interface CustomViewController : BaseViewController<UIScrollViewDelegate>
/**
 底部滑动图层
 */
@property (nonatomic ,strong ) UIScrollView * backScrollView;

/**
 上方视图
 */
@property (nonatomic ,strong ) UIView * rearTopView;

/**
 呈在上方的固定View
 */
@property (nonatomic ,strong ) UIView * frontTopView;
/**
 呈现在上方滑动图层
 */
@property (nonatomic ,strong ) UIScrollView * frontScrollView;
/**
 拖拽高度
 */
@property (nonatomic ,assign ) NSInteger DraggingHeight;

/**
 底部scrollFrame
 */
@property (nonatomic ,assign ) CGRect  backScrollFrame;



/**
 刷新UI  ***********必实现***********
 */
- (void)setUpSuperViewViewControllerUI;

@end
