//
//  PaySelectVC.m
//  GPhoneFlowiOSClient
//
//  Created by RKL on 16/9/15.
//  Copyright © 2016年 ZhentaiNing. All rights reserved.
//

#import "PaySelectVC.h"
#import "WXApiResponseHandler.h"
#import "WXApiManager.h"
#import "payStatusVC.h"
#import "ALiPayApiResponseHandler.h"
#import "ALiPayApiManager.h"
#import "ExecuteWXPayBussiness.h"
#import "ExecuteAliPayBussiness.h"
@interface PaySelectVC ()<WXApiManagerDelegate,ALiApiManagerDelegate>

@end

@implementation PaySelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
    self.navBarView.backgroundColor = [UIColor colorWithHexString:@"d43c33"];
    [self.navBarView setTitle:@"支付"];
    [WXApiManager sharedManager].delegate = self;
    [ALiPayApiManager sharedManager].delegate = self;
    [self privateBuildUI];
}

#pragma mark - 构建UI
- (void)privateBuildUI
{
    UIButton * wxImageView = [[UIButton alloc] init];
    [wxImageView setImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
    wxImageView.tag = 10000;
    [wxImageView addTarget:self action:@selector(goToPayWithpayChannel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wxImageView];
    
    [wxImageView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.view.mas_top).offset(NAV_BAR_HEIGHT + 30);
         make.left.equalTo(self.view.mas_left).offset(30);
         make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 60, (SCREEN_HEIGHT - NAV_BAR_HEIGHT - 90)/2));
     }];
    wxImageView.layer.backgroundColor = [UIColor colorWithHexString:@"f0f0f0"].CGColor;
    
    
    UIButton * zhifubaoImageView = [[UIButton alloc] init];
    [zhifubaoImageView setImage:[UIImage imageNamed:@"zhifubao"] forState:UIControlStateNormal];
    [zhifubaoImageView addTarget:self action:@selector(goToPayWithpayChannel:) forControlEvents:UIControlEventTouchUpInside];
    zhifubaoImageView.tag = 10001;

    [self.view addSubview:zhifubaoImageView];
    zhifubaoImageView.layer.backgroundColor = [UIColor colorWithHexString:@"f0f0f0"].CGColor;
    
    [zhifubaoImageView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(wxImageView.mas_bottom).offset(30);
         make.left.equalTo(self.view.mas_left).offset(30);
         make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 60, (SCREEN_HEIGHT - NAV_BAR_HEIGHT - 90)/2));
     }];
}

- (void) goToPayWithpayChannel:(UIButton *)changelBtn
{
    NSString * changelType;
    switch (changelBtn.tag - 10000) {
        case 0: {
			[ExecuteWXPayBussiness requestExecuteWXPayWithToken:TOKEN price:@"300" completionSuccessHandler:^(WeChaPayModel *weChaPayModel) {
				
				[WXApiResponseHandler jumpToWxPayWithData:weChaPayModel];
				
			} completionFailHandler:^(NSString *failMessage) {
				
			} completionError:^(NSString *netWorkErrorMessage) {
				
			}];
			
		}
			break;
		case 1: {
			
			[ExecuteAliPayBussiness requestExecuteAliPayWithToken:TOKEN price:@"300" completionSuccessHandler:^(NSString *orderInfoStr) {
				[ALiPayApiResponseHandler jumpToALiPayWithData:orderInfoStr];

			} completionFailHandler:^(NSString *failMessage) {
				
			} completionError:^(NSString *netWorkErrorMessage) {
				
			}];
		}
		default:
            break;
    }



}

#pragma mark - 支付支付结果代理
- (void) paySuccessd {
    payStatusVC * statusVC = [[payStatusVC alloc] initWithNibName:@"payStatusVC" bundle:nil];
    statusVC.payStatus = payStatusSuccessd;
    [self presentViewController:statusVC animated:YES completion:nil];
    
}
- (void) payFail {
    payStatusVC * statusVC = [[payStatusVC alloc] initWithNibName:@"payStatusVC" bundle:nil];
    statusVC.payStatus = payStatusFail;

    [self presentViewController:statusVC animated:YES completion:nil];
}
- (void) payCancel {
    payStatusVC * statusVC = [[payStatusVC alloc] initWithNibName:@"payStatusVC" bundle:nil];
    statusVC.payStatus = payStatusCancel;
[self presentViewController:statusVC animated:YES completion:nil];}
@end
