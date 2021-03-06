//
//  AccountManagementViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/19.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "AccountManagementViewController.h"
#import "UpdatePasswordViewController.h"
#import  "AccountViewController.h"
@interface AccountManagementViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *storeName;

@end

@implementation AccountManagementViewController
- (IBAction)updatePwd:(id)sender {
	
	UpdatePasswordViewController * updatePasswordViewController = [[UpdatePasswordViewController alloc] init];
	[self.navigationController pushViewController:updatePasswordViewController animated:YES];
	
}
- (IBAction)clickLoginOut:(id)sender {
    APP_DELEGATE.customTabBar.tabBarView.selectedIndex = 0;
    [self.navigationController popViewControllerAnimated:YES];
    clearUserDefaults();
    [CommonNotification postNotification:CNotificationLogOut userInfo:nil object:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
    [self.navBarView setTitle:@"用户管理"];
	
	self.userName.text = (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"managerName"];
//	self.storeName.text = (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"storeAddress"];

	
	UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo:)];
	self.storeName.userInteractionEnabled = YES;
	[self.storeName addGestureRecognizer:tapGesture];
}
-(void)Actiondo:(id)sender{
	AccountViewController * accountViewController = [[AccountViewController alloc] init];
	[self.navigationController pushViewController:accountViewController animated:YES];
	
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
