//
//  NewDemandViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/19.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "NewDemandViewController.h"
#import "NewDemandView.h"
#import "SRCustomDataPicker.h"
#import  "NewProductDemandBussiness.h"
#import "NewProductDemandSaveBussiness.h"

@interface NewDemandViewController ()<UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *selectCategoryButton;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UITextField *productName;
@property (weak, nonatomic) IBOutlet UITextField *productBand;
@property (weak, nonatomic) IBOutlet UITextField *productGuige;
//供应商
@property (weak, nonatomic) IBOutlet UITextView *supplierText;
@property (weak, nonatomic) IBOutlet UITextField *priceLabel;
@property (weak, nonatomic) IBOutlet UITextView *RemarksText;
@property (weak, nonatomic) IBOutlet UITextField *contactInformation;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (nonatomic ,strong ) SRCustomDataPicker * dataPicker;
@property (nonatomic ,strong ) NewProductDemandModel * selectModel;
@property (nonatomic ,assign ) BOOL canScrollCloseKeyBoard;

@end

@implementation NewDemandViewController
- (IBAction)clickSubmitButton:(UIButton *)sender {
	
	if (self.selectModel ==nil) {
		[self showToastWithMessage:@"请选择类别" showTime:1];
		return;
		
	}
	
	[NewProductDemandSaveBussiness requestNewProductDemandSaveWithToken:TOKEN
															  goodsName:self.productName.text
														goodsCategoryId:self.selectModel.categoryId
															  goodsSpec:self.productGuige.text
																upplier:self.supplierText.text
																  price:self.priceLabel.text
															  telephone:self.contactInformation.text
																 remark:self.RemarksText.text
											   completionSuccessHandler:^(BOOL succeed)
	{
		
		[self.navigationController popViewControllerAnimated:YES];
	} completionFailHandler:^(NSString *failMessage)
	{
		[self showToastWithMessage:failMessage showTime:1];
	
	} completionError:^(NSString *netWorkErrorMessage) {
		[self showToastWithMessage:netWorkErrorMessage showTime:1];
	}];
}
- (IBAction)clikcSelectCategory:(UIButton *)sender {
	
	[_productName resignFirstResponder];
	[_productBand resignFirstResponder];
	[_productGuige resignFirstResponder];
	[_supplierText resignFirstResponder];
	[_priceLabel resignFirstResponder];
	[_RemarksText resignFirstResponder];
	[_contactInformation resignFirstResponder];
	

	self.submitButton.enabled = YES;
	self.submitButton.backgroundColor = [UIColor colorWithHexString:Main_Font_Green_Color];
	[_dataPicker showDataPicker];
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initNavBarView:NAV_BAR_TYPE_SECOND_LEVEL_VIEW];
    [self.navBarView setTitle:@"反馈"];
    NewDemandView *newDemandView = [[NSBundle mainBundle] loadNibNamed:@"NewDemandView" owner:self options:nil].firstObject;
    newDemandView.frame = CGRectMake(0, 0, SCREEN_WIDTH, newDemandView.height);
    [self.mainScrollView addSubview:newDemandView];
    self.mainScrollView.contentSize = CGSizeMake(0, newDemandView.height + 100);
    
    _productName.delegate = self;
    _productBand.delegate = self;
    _productGuige.delegate = self;
    _supplierText.delegate = self;
    _priceLabel.delegate = self;
    _RemarksText.delegate = self;
    _contactInformation.delegate = self;
	_dataPicker = [[SRCustomDataPicker alloc] init];
	

	
	
	_supplierText.layer.masksToBounds = YES;
	_supplierText.layer.cornerRadius = 5;
	_supplierText.layer.borderWidth = 1;
	_supplierText.layer.borderColor = [[UIColor colorWithHexString:Main_Line_Gary_Color] CGColor];
	
	_RemarksText.layer.masksToBounds = YES;
	_RemarksText.layer.cornerRadius = 5;
	_RemarksText.layer.borderWidth = 1;
	_RemarksText.layer.borderColor = [[UIColor colorWithHexString:Main_Line_Gary_Color] CGColor];
	
	
	__weak typeof(self) weakSelf = self;
	_dataPicker.selectCategory = ^(NewProductDemandModel *model) {
		weakSelf.selectModel = model;
		[weakSelf.selectCategoryButton setTitle:model.categoryName forState:UIControlStateNormal];
	};
	
	[self.view addSubview:_dataPicker];
	self.mainScrollView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullToRefresh)];
	[self.mainScrollView.mj_header beginRefreshing];
	self.mainScrollView.delegate = self;
	
}

- (void)pullToRefresh {

	[NewProductDemandBussiness requestNewProductDemandWithToken:TOKEN completionSuccessHandler:^(NSArray<NewProductDemandModel *> *modelArray) {
		_dataPicker.dataSourse = @[modelArray];
		[_dataPicker relodeData];
		[self.mainScrollView.mj_header endRefreshing];

	} completionFailHandler:^(NSString *failMessage) {
		[self showToastWithMessage:failMessage showTime:1];
		[self.mainScrollView.mj_header endRefreshing];
	} completionError:^(NSString *netWorkErrorMessage) {
		[self.mainScrollView.mj_header endRefreshing];
		[self showToastWithMessage:netWorkErrorMessage showTime:1];
	}];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    CGRect rect=[textView convertRect: textView.bounds toView:APP_DELEGATE.window];
	self.canScrollCloseKeyBoard = YES;

    if ((_mainScrollView.contentOffset.y  + rect.origin.y - 200) > 0) {
		self.canScrollCloseKeyBoard = NO;
        [self.mainScrollView setContentOffset:CGPointMake(0, _mainScrollView.contentOffset.y  + rect.origin.y - 200) animated:YES];
    }
    
    

}

- (void)textFieldDidBeginEditing:(UITextField *)textField {

	CGRect rect=[textField convertRect: textField.bounds toView:APP_DELEGATE.window];
	self.canScrollCloseKeyBoard = YES;
	
	if ((_mainScrollView.contentOffset.y  + rect.origin.y - 200) > 0) {
		self.canScrollCloseKeyBoard = NO;
		[self.mainScrollView setContentOffset:CGPointMake(0, _mainScrollView.contentOffset.y  + rect.origin.y - 200) animated:YES];
	}
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {

	self.canScrollCloseKeyBoard = NO;
	

	return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

	self.canScrollCloseKeyBoard = NO;
	
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

	

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	if (self.canScrollCloseKeyBoard) {
		[self.view endEditing:YES];
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
