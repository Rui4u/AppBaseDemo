//
//  AddInfoVC.m
//  GPhoneFlowiOSClient
//
//  Created by Livia on 16/9/12.
//  Copyright © 2016年 ZhentaiNing. All rights reserved.
//

#import "AddInfoVC.h"

@interface AddInfoVC()<UITextFieldDelegate>
/**
 *  用户名
 */
@property (nonatomic , strong) UITextField * userNameTextField;
/**
 *  密码
 */
@property (nonatomic , strong) UITextField * accountNumberTextField;
/**
 *  确定按钮
 */
@property (nonatomic , strong) UIButton * sureBtn;
@end

@implementation AddInfoVC

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
    self.navBarView.backgroundColor = [UIColor colorWithHexString:@"d43c33"];
    [self.navBarView setTitle:@"添加"];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到view上
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    [self privateBuildUI];
    
}

#pragma mark - 创建UI
- (void)privateBuildUI
{
    UILabel * infoLabel = [UILabel quickCreateLabelWithFrame:CGRectZero
                                                  textString:@"绑定实名认证过的支付宝账号才能收款"
                                                        font:15];
    infoLabel.textColor = [UIColor colorWithHexString:@"999999"];
    infoLabel.frame = CGRectMake(12, NAV_BAR_HEIGHT+15, SCREEN_WIDTH-24, 16);
    [self.view addSubview:infoLabel];
    
    
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(infoLabel.frame)+15, SCREEN_WIDTH, 100.5)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    _userNameTextField = [UITextField quickCreateTextFieldWithFrame:CGRectZero
                                                          textString:@""
                                                                font:17];
    _userNameTextField.placeholder = @"收款人姓名";
    _userNameTextField.delegate = self;
    _userNameTextField.frame = CGRectMake(12, 0, SCREEN_WIDTH-24, 50);
    [bgView addSubview:_userNameTextField];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"ebebeb"];
    [bgView addSubview:lineView];
    
    _accountNumberTextField = [UITextField quickCreateTextFieldWithFrame:CGRectZero
                                                         textString:@""
                                                               font:17];
    _accountNumberTextField.placeholder = @"收款人账号";
    _accountNumberTextField.delegate = self;
    _accountNumberTextField.frame = CGRectMake(12, 50.5, SCREEN_WIDTH-24, 50);
    [bgView addSubview:_accountNumberTextField];
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.backgroundColor = [UIColor colorWithHexString:@"999999"];
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.sureBtn.layer setMasksToBounds:YES];
    [self.sureBtn.layer setCornerRadius:5.0];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sureBtn.userInteractionEnabled = NO;
    [self.sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sureBtn];
    
    self.sureBtn.frame = CGRectMake(12, CGRectGetMaxY(bgView.frame)+30, SCREEN_WIDTH-24, 50);
}

#pragma mark - 确定按钮点击事件
- (void)sureBtnClick
{
    [AccountBindBusiness accountBindWithToken:(NSString * )[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]
                              withdrawAccount:self.accountNumberTextField.text
                                         name:self.userNameTextField.text
                     completionSuccessHandler:^(Boolean successFlag) {
                         
                         if ([self.delegate respondsToSelector:@selector(bringUserName:accountNumber:)])
                         {
                             [self.delegate bringUserName:self.userNameTextField.text accountNumber:self.accountNumberTextField.text];
                         }
                         
                         [self.navigationController popViewControllerAnimated:YES];
                         
                     }
                        completionFailHandler:^(NSString *failMessage)
                        {
                            [self showToastWithMessage:failMessage showTime:2.0f];
                        }
                        completionError:^(NSString *netWorkErrorMessage)
                        {
                            [self showToastWithMessage:netWorkErrorMessage showTime:2.0f];
                     }];
}

#pragma mark - textField代理方法
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([self.userNameTextField.text isEqualToString:@""] || [self.accountNumberTextField.text isEqualToString:@""])
    {
        self.sureBtn.backgroundColor = [UIColor colorWithHexString:@"999999"];
    }
    else
    {
        self.sureBtn.userInteractionEnabled = YES;
        self.sureBtn.backgroundColor = [UIColor colorWithHexString:MAIN_RED_COLOR];
    }
    return YES;
}


#pragma mark - 收键盘
-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [self.userNameTextField resignFirstResponder];
    [self.accountNumberTextField resignFirstResponder];
}
@end









