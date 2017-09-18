//
//  UpdatePasswordViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/9/5.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "UpdatePasswordViewController.h"
#import "UpdatePwdBussiness.h"
@interface UpdatePasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPwdLabel;
@property (weak, nonatomic) IBOutlet UITextField *updatePwdLabel;

@property (weak, nonatomic) IBOutlet UIButton *updateButton;

@end

@implementation UpdatePasswordViewController

- (IBAction)clickupdateButton:(UIButton *)sender {
	[self.view endEditing:YES];
	NSLog(@"点击修改");
	[UpdatePwdBussiness requestStoreInfoWithToken:TOKEN oldPwd:self.oldPwdLabel.text newPwd:self.updatePwdLabel.text completionSuccessHandler:^(BOOL succeed) {
		
		
		[self showToastWithMessage:@"修改密码成功 请重新登录" showTime:1];
		clearUserDefaults();
		[self showLoginViewController:nil];
		[self.navigationController popToRootViewControllerAnimated:YES];
		APP_DELEGATE.customTabBar.tabBarView.selectedIndex = 0;
		
	} completionFailHandler:^(NSString *failMessage) {
		[self showToastWithMessage:failMessage showTime:1];
	} completionError:^(NSString *netWorkErrorMessage) {
		[self showToastWithMessage:netWorkErrorMessage showTime:1];
	}];
}

- (IBAction)ClickopenOrClosr:(UIButton *)sender {
	
	
	self.updatePwdLabel.secureTextEntry = !self.updatePwdLabel.secureTextEntry;
	sender.selected = !sender.selected;
}
- (void)viewDidLoad {
	[super viewDidLoad];
	[self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
	[self.navBarView setTitle:@"修改密码"];
	
	
	[self.oldPwdLabel addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	[self.updatePwdLabel addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	self.updatePwdLabel.clearButtonMode = UITextFieldViewModeWhileEditing;
	
}
- (void)textFieldDidChange:(UITextField *)textFiled {
	
	if ([self.oldPwdLabel.text isEqualToString:@""]|| [self.updatePwdLabel.text isEqualToString:@""]) {
		
		[self.updateButton setBackgroundColor:[UIColor colorWithHexString:Main_Button_Gary_Color]];
		self.updateButton.enabled = NO;
	}else {
		[self.updateButton setBackgroundColor:[UIColor colorWithHexString:Main_Font_Green_Color]];
		self.updateButton.enabled = YES;
	}
	
	
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	[self.oldPwdLabel resignFirstResponder];
	[self.updatePwdLabel resignFirstResponder];
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}
- (void)back{
	[self.navigationController popViewControllerAnimated:YES];
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
