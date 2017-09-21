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
@property (weak, nonatomic) IBOutlet UIButton *aliPayButton;
@property (weak, nonatomic) IBOutlet UIButton *wxPayButton;

@property (nonatomic ,assign ) NSInteger currentTag;

@property (nonatomic ,strong ) UIButton * lastBtn;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceNumber;
@end

@implementation PaySelectVC
- (IBAction)sureButton:(id)sender {
	
	switch (self.currentTag) {
		case 0: {
			[ExecuteWXPayBussiness requestExecuteWXPayWithToken:TOKEN price:self.totolPrice orderNum:self.orderNumber completionSuccessHandler:^(WeChaPayModel *weChaPayModel) {
				
				[WXApiResponseHandler jumpToWxPayWithData:weChaPayModel];
				
			} completionFailHandler:^(NSString *failMessage) {
				
			} completionError:^(NSString *netWorkErrorMessage) {
				
			}];
			
		}
			break;
		case 1: {
			
			[ExecuteAliPayBussiness requestExecuteAliPayWithToken:TOKEN price:self.totolPrice orderNum:self.orderNumber completionSuccessHandler:^(NSString *orderInfoStr) {
				
				[ALiPayApiResponseHandler jumpToALiPayWithData:orderInfoStr];
				
			} completionFailHandler:^(NSString *failMessage) {
				
			} completionError:^(NSString *netWorkErrorMessage) {
				
			}];
		}
		default:
			break;
	}

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
    [self.navBarView setTitle:@"支付"];
    [WXApiManager sharedManager].delegate = self;
    [ALiPayApiManager sharedManager].delegate = self;
	self.orderNumberLabel.text = self.orderIdNumber;
	self.priceNumber.text = self.totolPrice;
	[self goToPayWith:self.aliPayButton];
	
}


- (IBAction)goToPayWith:(UIButton *)changelBtn {
	changelBtn.selected = YES;
	self.currentTag = changelBtn.tag - 10000;
	self.lastBtn.selected = NO;
	self.lastBtn = changelBtn;


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
