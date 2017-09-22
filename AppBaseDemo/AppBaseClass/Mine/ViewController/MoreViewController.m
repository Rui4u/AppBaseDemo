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
#import "ProtocolViewController.h"
#import "QuestionViewController.h"
#import "ServerCenterViewController.h"
#import "ErweimaViewController.h"
@interface MoreViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *storeName;

@property (weak, nonatomic) IBOutlet UIImageView *userPic;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UILabel *notLoginLabel;
@property (nonatomic ,strong ) MoreBaseView * moreBaseView;
@end

@implementation MoreViewController

- (void)privateReferRootReciveLogOutSucess {
	
	clearUserDefaults();
	self.notLoginLabel.hidden = !isNotLogin;
	self.userName.hidden = isNotLogin;
	self.storeName.hidden = isNotLogin;
	
	self.userName.text = (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"managerName"];
	self.storeName.text = (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"storeAddress"];


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
	}else if (tag == 3){
	
		MyInvoiceViewController * myInvoiceViewController = [[MyInvoiceViewController alloc] init];
		[self.navigationController pushViewController:myInvoiceViewController animated:YES];
	}else if (tag == 2){
		APP_DELEGATE.customTabBar.tabBarView.selectedIndex = 2;
		
	}else{
		[self showToastWithMessage:@"暂未开通" showTime:1];
	}
	
}

- (IBAction)clickHelpCenterButton:(UIButton *)sender {
	
	NSInteger tag = sender.tag - 1000;
	if (tag == 1) {
	
		QuestionViewController * protocolViewController = [[QuestionViewController alloc] init];
		[self.navigationController pushViewController:protocolViewController animated:YES];
	}else if (tag == 2){
	
		ServerCenterViewController * serverCenterViewController = [[ServerCenterViewController alloc] init
														   ];
		[self.navigationController pushViewController:serverCenterViewController animated:YES];
	}else if (tag == 5){
		
		
		ErweimaViewController * serverCenterViewController = [[ErweimaViewController alloc] init
																   ];
		[self.navigationController pushViewController:serverCenterViewController animated:YES];
		
	}else {
		
		UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"拨打电话"
																				 message:@"028-26222908"
																		  preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
		UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
								   {
									   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",@"028-26222908"]]];
								   }];
		[alertController addAction:cancelAction];
		[alertController addAction:okAction];
		
		
		[self presentViewController:alertController animated:YES completion:nil];
	}
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	MoreBaseView * moreBaseView = [[NSBundle mainBundle] loadNibNamed:@"MoreBaseView" owner:self options:nil].firstObject;
	self.moreBaseView = moreBaseView;
	moreBaseView.frame = CGRectMake(0, 0, SCREEN_WIDTH, moreBaseView.height);
    
	[_bgScrollView addSubview:moreBaseView];
	
    [moreBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgScrollView.mas_left);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.top.equalTo(self.bgScrollView.mas_top);
        make.height.mas_equalTo(moreBaseView.height);
    }];

	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(privateReferRootReciveLogOutSucess)
												 name:CNotificationLogOut
											   object:nil];
    
    self.notLoginLabel.hidden = !isNotLogin;
    self.userName.hidden = isNotLogin;
    self.storeName.hidden = isNotLogin;
	
	self.userName.text = (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"managerName"];
	self.storeName.text = (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"storeAddress"];

	
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
