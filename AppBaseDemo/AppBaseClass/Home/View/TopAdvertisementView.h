//
//  TopAdvertisementView.h
//  HZAgentiOSClient
//
//  Created by sharui on 2016/11/14.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AdvertisementViewDelegate<NSObject>
- (void)clickAdverrismentWithUrl:(NSString *)url withUrlTitle:(NSString *)urlTitle;
@end
/**
 *   广告
 */
@interface TopAdvertisementView : UIView

@property (nonatomic ,strong ) NSArray *bannerListArray;

@property (nonatomic , weak)id <AdvertisementViewDelegate>delegate;
/**
 广告
 */
@property (nonatomic ,strong )UICollectionView * collectionView;
@end

