//
//  UserInfoViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/8.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserLocationViewController.h"
@interface UserInfoViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *storeNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *managerNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *storeAdressButton;
@property (weak, nonatomic) IBOutlet UITextField *storeAdressDesTextField;
@property (weak, nonatomic) IBOutlet UITextField *joinCode;

@end

@implementation UserInfoViewController
//跳转地图 选择位置
- (IBAction)clickSelectStoreAdressTextField:(UIButton *)sender {
	
	UserLocationViewController * userLocationViewController = [[UserLocationViewController alloc] init];
	[self.navigationController pushViewController:userLocationViewController animated:YES];

}

//提交
- (IBAction)clickSubmitButton:(UIButton *)sender {
	
}



- (void)viewDidLoad {
    [super viewDidLoad];
	[self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
	[self.navBarView setTitle:@"完善信息"];
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
