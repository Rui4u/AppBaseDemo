//
//  productImageScrollView.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
@class BannerList;
@protocol ProductImageScrollViewDelegate<NSObject>
- (void)clickAdverrismentWithUrl:(NSString *)url withUrlTitle:(NSString *)urlTitle;
@end
/**
 *   广告
 */
@interface TopProductImageScrollView : UIView

@property (nonatomic ,strong ) NSArray *dataSourse;

@property (nonatomic , weak)id <ProductImageScrollViewDelegate>delegate;
/**
 广告
 */
@property (nonatomic ,strong )UICollectionView * collectionView;
@end
