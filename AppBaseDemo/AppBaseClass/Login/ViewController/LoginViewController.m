//
//  LoginViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/2.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
	[self.navBarView setTitle:@"登录"];
	
	UIButton * registerButton = [UIButton quickCreateButtonWithFrame:CGRectMake(SCREEN_WIDTH-AutoHeight(60)-AutoHeight(10), 20, AutoHeight(60), AutoHeight(44))
													  title:@"注册"
												  addTarget:self
													 action:@"clickRegisterButton"];
	registerButton.titleLabel.font = [UIFont systemFontOfSize:12];
	[registerButton setTitleColor:MAIN_GREEN_COLOR forState:UIControlStateNormal];
	[self.navBarView addSubview:registerButton];
	
	
}
- (void)clickRegisterButton {
	RegisterViewController * registerViewController = [[RegisterViewController alloc] init];
	[self.navigationController pushViewController:registerViewController animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)back{
	[self dismissViewControllerAnimated:YES completion:nil];
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
