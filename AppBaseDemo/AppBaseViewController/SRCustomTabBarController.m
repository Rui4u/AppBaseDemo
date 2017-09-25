//
//  SRCustomTabBarController.m
//  HZPrivateEquityiOSClient
//
//  Created by sharui on 2016/10/19.
//  Copyright © 2016年 sharui. All rights reserved.
//

#import "SRCustomTabBarController.h"

@implementation SRCustomTabBarController

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.tabBar.hidden = YES;
		SRCustomTabBarView * tabBarView = [[SRCustomTabBarView alloc] init];
		self.tabBarView = tabBarView;
		[self.view addSubview:tabBarView];
        
        [tabBarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
            make.height.mas_equalTo(49);
        }];
	}
	return self;
}



@end
