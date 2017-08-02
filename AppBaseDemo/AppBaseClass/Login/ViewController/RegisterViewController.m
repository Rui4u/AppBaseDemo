//
//  RegisterViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/2.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
	[self.navBarView setTitle:@"注册"];
	
	
	UIButton * phontButton = [UIButton quickCreateButtonWithFrame:CGRectMake(SCREEN_WIDTH-AutoHeight(60)-AutoHeight(10), 20, AutoHeight(60), AutoHeight(44))
															   title:@"客服电话"
														   addTarget:self
															  action:@"clickPhoneButton"];
	phontButton.titleLabel.font = [UIFont systemFontOfSize:12];
	[phontButton setTitleColor:MAIN_GREEN_COLOR forState:UIControlStateNormal];
	[self.navBarView addSubview:phontButton];
}

- (void)clickPhoneButton {


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
