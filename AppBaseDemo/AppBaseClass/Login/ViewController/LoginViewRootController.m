
//
//  LoginViewRootController.m
//  HZPrivateEquityiOSClient
//
//  Created by sharui on 2016/10/26.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "LoginViewRootController.h"
#import "LoginViewController.h"
#import "CommonNotification.h"

@interface LoginViewRootController ()


@end

@implementation LoginViewRootController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setRootViewController];

		self.title = @"注册";
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loginViewRootControllerBlock:)
                                                     name:LoginViewRootControllerBlock
                                                   object:nil];
    }
    return self;
}

#pragma mark - 推出检测手机号页面
- (void) setRootViewController
{
    LoginViewController * login = [[LoginViewController alloc] init];
    [self pushViewController:login animated:NO];
}

- (void)loginViewRootControllerBlock:(NSNotification *)notification {
	NSLog(@"登录后回调");
	
}

- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LoginViewRootControllerBlock object:nil];
}
@end
