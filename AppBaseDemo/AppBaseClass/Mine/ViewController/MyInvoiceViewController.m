//
//  MyInvoiceViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/22.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "MyInvoiceViewController.h"
#import "MyInvoiceInfoView.h"
#import "MyInvoiceBussiness.h"
@interface MyInvoiceViewController ()<UITextFieldDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;
@property (strong, nonatomic)  UIButton *lastButton;
@property (weak, nonatomic) IBOutlet UITextField *InvoiceHeader;
@property (weak, nonatomic) IBOutlet UITextField *taxpayerIdentificationNumber;//纳税人识别号
@property (weak, nonatomic) IBOutlet UITextField *registeredAddress;
@property (weak, nonatomic) IBOutlet UITextField *registeredPhone;
@property (weak, nonatomic) IBOutlet UITextField *bank;
@property (weak, nonatomic) IBOutlet UITextField *bankAccount;
@property (weak, nonatomic) IBOutlet UITextField *billingTime;
@property (weak, nonatomic) IBOutlet UITextField *firstInvoiceStartDate;
@property (weak, nonatomic) IBOutlet UITextField *mailbox;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (nonatomic ,assign ) BOOL canScrollCloseKeyBoard;
@end

@implementation MyInvoiceViewController
- (IBAction)clickSubmitButton:(UIButton *)sender {
	
	if ([self.InvoiceHeader.text isEqualToString:@""]||
		[self.taxpayerIdentificationNumber.text isEqualToString:@""]||
		[self.registeredAddress.text isEqualToString:@""]||
		[self.registeredPhone.text isEqualToString:@""]||
		[self.bankAccount.text isEqualToString:@""]||
		[self.billingTime.text isEqualToString:@""]||
		[self.firstInvoiceStartDate.text isEqualToString:@""]||
		[self.bank.text isEqualToString:@""]) {
		[self showToastWithMessage:@"请全部填写" showTime:1];
		return;
	}
	
	
	[MyInvoiceBussiness requestMyInvoiceWithToken:TOKEN
											 type:[NSString stringWithFormat:@"%tu",self.lastButton.tag - 1000]
											start:self.InvoiceHeader.text
									   taxpayerId:self.taxpayerIdentificationNumber.text
										regAddres:self.registeredAddress.text
										 regPhone:self.registeredPhone.text
										 telphone:@""
										  account:self.bankAccount.text
										  addTime:self.billingTime.text
										startTime:self.firstInvoiceStartDate.text
											 mail:self.mailbox.text
						 completionSuccessHandler:^(BOOL succeed)
	 {
		 [self.navigationController popViewControllerAnimated:YES];
		 [self showToastWithMessage:@"提交成功" showTime:1];
		 
	 } completionFailHandler:^(NSString *failMessage) {
		 
	 } completionError:^(NSString *netWorkErrorMessage) {
		 
	 }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
	[self.navBarView setTitle:@"我的发票"];
    // Do any additional setup after loading the view from its nib.
	MyInvoiceInfoView * myInvoiceInfoView = [[NSBundle mainBundle] loadNibNamed:@"MyInvoiceInfoView" owner:self options:nil].firstObject;
	myInvoiceInfoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, myInvoiceInfoView.height);
	[self.bgScrollView addSubview:myInvoiceInfoView];
	self.bgScrollView.contentSize = myInvoiceInfoView.size;

	
	self.InvoiceHeader.delegate = self;
	self.taxpayerIdentificationNumber.delegate = self;
	self.registeredAddress.delegate = self;
	self.registeredPhone.delegate = self;
	self.bankAccount.delegate = self;
	self.billingTime.delegate = self;
	self.firstInvoiceStartDate.delegate = self;
	self.bank.delegate = self;
	self.mailbox.delegate = self;
	
	
	[self.InvoiceHeader addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	[self.taxpayerIdentificationNumber addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	[self.registeredAddress addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	[self.registeredPhone addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	[self.bankAccount addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	[self.billingTime addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	[self.firstInvoiceStartDate addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	[self.bank addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	
	self.bgScrollView.delegate = self;
}
- (IBAction)clickInvoiceType:(UIButton *)sender {
	self.lastButton.selected = NO;
	sender.selected = YES;
	self.lastButton = sender;
	
}

- (void)textFieldDidChange:(UITextField *)textFiled {
	
	if ([self.InvoiceHeader.text isEqualToString:@""]||
		[self.taxpayerIdentificationNumber.text isEqualToString:@""]||
		[self.registeredAddress.text isEqualToString:@""]||
		[self.registeredPhone.text isEqualToString:@""]||
		[self.bankAccount.text isEqualToString:@""]||
		[self.billingTime.text isEqualToString:@""]||
		[self.firstInvoiceStartDate.text isEqualToString:@""]||
		[self.bank.text isEqualToString:@""]) {
		self.submitButton.backgroundColor = [UIColor colorWithHexString:Main_Button_Gary_Color];
		self.submitButton.enabled = NO;
		
	}else {
		
		
		self.submitButton.backgroundColor = [UIColor colorWithHexString:Main_Font_Green_Color];
		self.submitButton.enabled = YES;
	}
	

}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	
	self.canScrollCloseKeyBoard = YES;
	
	CGRect rect=[textField convertRect: textField.bounds toView:APP_DELEGATE.window];
	if ((_bgScrollView.contentOffset.y  + rect.origin.y - 200) > 0) {
		self.canScrollCloseKeyBoard = NO;
		[self.bgScrollView setContentOffset:CGPointMake(0, _bgScrollView.contentOffset.y  + rect.origin.y - 200) animated:YES];
	}
	
	return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

	
		

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	if (self.canScrollCloseKeyBoard) {
		[self.InvoiceHeader resignFirstResponder];
		[self.taxpayerIdentificationNumber resignFirstResponder];
		[self.registeredAddress resignFirstResponder];
		[self.registeredPhone resignFirstResponder];
		[self.bankAccount resignFirstResponder];
		[self.billingTime resignFirstResponder];
		[self.firstInvoiceStartDate resignFirstResponder];
		[self.bank resignFirstResponder];
		[self.mailbox resignFirstResponder];
	
	}
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {

	self.canScrollCloseKeyBoard = YES;
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
