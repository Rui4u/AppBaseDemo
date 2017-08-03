//
//  LoginViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/2.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "LoginBusiness.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController
- (IBAction)clickLoginButton:(UIButton *)sender {
    
    NSLog(@"点击登录");
    [LoginBusiness loginWithStoreTelephone:self.phoneNumberTextField.text storePwd:self.userPwdTextField.text completionSuccessHandler:^(BOOL sucessFlag) {
        
    } completionFailHandler:^(NSString *failMessage) {
        [self showToastWithMessage:failMessage showTime:1];
    } completionError:^(NSString *netWorkErrorMessage) {
        [self showToastWithMessage:netWorkErrorMessage showTime:1];
    }];
}

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
	

    [self.phoneNumberTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.userPwdTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.userPwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
}
- (void)textFieldDidChange:(UITextField *)textFiled {

    if ([self.phoneNumberTextField.text isEqualToString:@""]|| [self.userPwdTextField.text isEqualToString:@""]) {
        
        [self.loginButton setBackgroundColor:[UIColor lightGrayColor]];
        self.loginButton.enabled = NO;
    }else {
        [self.loginButton setBackgroundColor:MAIN_GREEN_COLOR];
        self.loginButton.enabled = YES;
    }


}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.phoneNumberTextField resignFirstResponder];
    [self.userPwdTextField resignFirstResponder];

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
