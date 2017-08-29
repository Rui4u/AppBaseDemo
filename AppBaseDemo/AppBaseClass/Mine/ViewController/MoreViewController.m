//
//  MoreViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/11.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreBaseView.h"
#import "OrderListViewController.h"
#import "AccountManagementViewController.h"
#import "NewDemandViewController.h"
#import "MyInvoiceViewController.h"
@interface MoreViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *userLevelImage;
@property (weak, nonatomic) IBOutlet UILabel *userLevel;
@property (weak, nonatomic) IBOutlet UIImageView *userPic;
@property (weak, nonatomic) IBOutlet UILabel *userManager;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UILabel *notLoginLabel;
@property (nonatomic ,strong ) MoreBaseView * moreBaseView;
@end

@implementation MoreViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.notLoginLabel.hidden = !isNotLogin;
    self.userName.hidden = isNotLogin;
    self.userLevel.hidden = isNotLogin;
    self.userLevelImage.hidden = isNotLogin;

}
- (IBAction)clickMyOrderButton:(UIButton *)sender {
    
    if (isNotLogin) {
        [self showLoginViewController:nil];
        return;
    }
    
	OrderListViewController * orderListViewController = [[OrderListViewController alloc] init];
    orderListViewController.state = [NSString stringWithFormat:@"%ld",sender.tag - 1000 + 1];//-1 是全部
	
	[self.navigationController pushViewController:orderListViewController animated:YES];
	
}
- (IBAction)clickUserManager:(id)sender {
    
    if (isNotLogin) {
        [self showLoginViewController:nil];
        return;
    }
    AccountManagementViewController * accountManagementViewController = [[AccountManagementViewController alloc] init];
    [self.navigationController pushViewController:accountManagementViewController animated:YES];
}
- (IBAction)clickNormalToolsButton:(UIButton *)sender {
	NSInteger tag = sender.tag - 1000;
	if (tag == 4) {
		NewDemandViewController * newDemandViewController = [[NewDemandViewController alloc] init];
		[self.navigationController pushViewController:newDemandViewController animated:YES];
	}else if (tag == 5){
	
		MyInvoiceViewController * myInvoiceViewController = [[MyInvoiceViewController alloc] init];
		[self.navigationController pushViewController:myInvoiceViewController animated:YES];
	}else {
		[self showToastWithMessage:@"暂未开通" showTime:1];
	}
	
}

- (IBAction)clickHelpCenterButton:(UIButton *)sender {
	[self showToastWithMessage:@"暂未开通" showTime:1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	MoreBaseView * moreBaseView = [[NSBundle mainBundle] loadNibNamed:@"MoreBaseView" owner:self options:nil].firstObject;
	self.moreBaseView = moreBaseView;
	moreBaseView.frame = CGRectMake(0, 0, SCREEN_WIDTH, moreBaseView.height);
	[_bgScrollView addSubview:moreBaseView];
	

    
    self.notLoginLabel.hidden = !isNotLogin;
    self.userName.hidden = isNotLogin;
    self.userLevel.hidden = isNotLogin;
    self.userLevelImage.hidden = isNotLogin;
    
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginIn)];
    
    [_notLoginLabel addGestureRecognizer:tapGesture];
    _notLoginLabel.userInteractionEnabled = YES;
	
}
- (void)loginIn {

    [self showLoginViewController:^(BOOL loginStatus) {
        
        APP_DELEGATE.customTabBar.selectedIndex = 0;
    }];
    
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	self.bgScrollView.contentSize = CGSizeMake(0, self.moreBaseView.height);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
