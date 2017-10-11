//
//  ForgetPasswordViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/10/11.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ForgetPasswordViewController.h"

#import "RegisterViewController.h"
#import "RegisterBusiness.h"
#import "UserInfoViewController.h"
#import "SendVCodeUpdateBussiness.h"
@interface ForgetPasswordViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *verificationCode;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;
@property (weak, nonatomic) IBOutlet UITextField *surePassword;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *getVerificationCoderButton;

@end

@implementation ForgetPasswordViewController

- (void)textFieldDidChange:(UITextField *)textFiled {
	
	if ([self.phoneNumber.text isEqualToString:@""]||
		[self.verificationCode.text isEqualToString:@""]||
		[self.userPassword.text isEqualToString:@""]||
		[self.surePassword.text isEqualToString:@""]) {
		
		[self.registerButton setBackgroundColor:[UIColor colorWithHexString:Main_Button_Gary_Color]];
		self.registerButton.enabled = NO;
	}else {
		[self.registerButton setBackgroundColor:[UIColor colorWithHexString:Main_Font_Green_Color]];
		self.registerButton.enabled = YES;
	}
}
- (IBAction)clickGetVerificationCoderButton:(UIButton *)sender {
	
	if (![self.phoneNumber.text isValidateMobile])
	{
		[self showToastWithMessage:@"请输入正确手机号码" showTime:1.0f];
		return ;
		
	}
	[self openTimerWithTime:60 countDownBtn:sender againAcquireColor:Main_Font_Green_Color countDownColor:Main_Font_Gary_Color];
	
	[SendVCodeUpdateBussiness requestStoreInfoWithPhoneNum:self.phoneNumber.text completionSuccessHandler:^(BOOL succeed) {
		
		[self showToastWithMessage:@"验证码发送成功" showTime:1];
		
	} completionFailHandler:^(NSString *failMessage) {
		[self showToastWithMessage:failMessage showTime:1];
		
	} completionError:^(NSString *netWorkErrorMessage) {
		[self showToastWithMessage:netWorkErrorMessage showTime:1];
		
	}];
	NSLog(@"验证码");
	
}
- (IBAction)ClickopenOrClosr:(UIButton *)sender {
	
	
	self.userPassword.secureTextEntry = !self.userPassword.secureTextEntry;
	self.surePassword.secureTextEntry = !self.surePassword.secureTextEntry;

	sender.selected = !sender.selected;
}

- (IBAction)clickRegisterButton:(UIButton *)sender {
	NSLog(@"修改密码123");
	
	[self.view endEditing:YES];
	
	if (![self.userPassword.text isEqualToString:self.surePassword.text]) {
		[self showToastWithMessage:@"两次密码输入不一致 请重新输入" showTime:1];
		return;
	}
	
	[RegisterBusiness registerWithStoreTelephone:self.phoneNumber.text
										storePwd:self.userPassword.text
									  verifyCode:self.verificationCode.text
						completionSuccessHandler:^(BOOL sucessFlag)
	 {
		 if (sucessFlag == YES) [self showToastWithMessage:@"注册成功" showTime:1];
		 
		 [self back];
		 
	 } completionFailHandler:^(NSString *failMessage) {
		 [self showToastWithMessage:failMessage showTime:1];
	 } completionError:^(NSString *netWorkErrorMessage) {
		 [self showToastWithMessage:netWorkErrorMessage showTime:1];
	 }];
}


- (void)viewDidLoad {
	[super viewDidLoad];
	[self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
	[self.navBarView setTitle:@"忘记密码"];
	
	[self.phoneNumber addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	[self.verificationCode addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	[self.userPassword addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	[self.surePassword addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
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
