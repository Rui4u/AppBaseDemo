//
//  HZCustomSearchBar.h
//  HZAgentiOSClient
//
//  Created by RKL on 17/8/1.
//  Copyright © 2017年 ZhentaiNing_Huizhong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM ( NSInteger , CustomSearchBarType) {
    
    CustomSearchBarType_searchView = 1, //纯展示用
    CustomSearchBarType_searchBar = 2, //搜索用

};



@protocol HZCustomSearchBarDelegate <NSObject>

@optional

- (void)searchBarShouldBeginEditing;

@end

/**
 自定义搜索框
 */
@interface HZCustomSearchBar : UIButton

/**
 搜索文字
 */
@property (nonatomic , copy) NSString * text;

/**
 默认字
 */
@property (nonatomic , copy) NSString * placeholder;

/**
 代理
 */
@property (nonatomic , weak) id<HZCustomSearchBarDelegate> delegate;

/**
 搜索框背景
 */
@property (nonatomic , strong) UIColor * searchBarBackgroundColor;

/**
 文本框的背景
 */
@property (nonatomic , copy) NSString * searchFieldBackgroundColor;

/**
 枚举
 */
@property (nonatomic , assign) CustomSearchBarType type;

@end






