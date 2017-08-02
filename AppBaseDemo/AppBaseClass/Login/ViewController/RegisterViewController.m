//
//  RegisterViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/2.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterBusiness.h"
@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *verificationCode;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *getVerificationCoderButton;

@end

@implementation RegisterViewController
- (IBAction)clickGetVerificationCoderButton:(UIButton *)sender {
    NSLog(@"获取验证码");
}
- (IBAction)clickRegisterButton:(UIButton *)sender {
    NSLog(@"注册");
    
    [RegisterBusiness registerWithStoreTelephone:self.phoneNumber.text
                                        storePwd:self.userPassword.text
                                verificationCode:nil completionSuccessHandler:^(BOOL sucessFlag)
    {
        if (sucessFlag == YES) [self showToastWithMessage:@"注册成功" showTime:1];
        
    } completionFailHandler:^(NSString *failMessage) {
        [self showToastWithMessage:failMessage showTime:1];
    } completionError:^(NSString *netWorkErrorMessage) {
        [self showToastWithMessage:netWorkErrorMessage showTime:1];
    }];
}
- (IBAction)clickServiceForH5Button:(id)sender {
    NSLog(@"点击注册服务条款");
}

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
