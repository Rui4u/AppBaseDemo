//
//  AddAccountViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/10/13.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "AddAccountViewController.h"
#import "SaveAccountBussiness.h"
@interface AddAccountViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation AddAccountViewController
- (IBAction)clickSaveButton:(id)sender {

	
	[SaveAccountBussiness requestSaveAccountWithToken:TOKEN trueName:self.name.text telPhone:self.phone.text completionSuccessHandler:^(NSDictionary *succeed) {
		[self.navigationController popViewControllerAnimated:YES];
		if (self.reloadeDataBlock) {
			self.reloadeDataBlock();
		}
	} completionFailHandler:^(NSString *failMessage) {
		
	} completionError:^(NSString *netWorkErrorMessage) {
		
	}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
	[self.navBarView setTitle:@"添加联系人"];
    // Do any additional setup after loading the view from its nib.
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
