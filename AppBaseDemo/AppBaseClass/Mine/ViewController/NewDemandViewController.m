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
@interface NewDemandViewController ()<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UITextField *productName;
@property (weak, nonatomic) IBOutlet UITextField *productBand;
@property (weak, nonatomic) IBOutlet UITextField *productGuige;
//供应商
@property (weak, nonatomic) IBOutlet UITextView *supplierText;
@property (weak, nonatomic) IBOutlet UITextField *priceLabel;
@property (weak, nonatomic) IBOutlet UITextView *RemarksText;
@property (weak, nonatomic) IBOutlet UITextField *contactInformation;
@property (nonatomic ,strong ) SRCustomDataPicker * dataPicker;
@end

@implementation NewDemandViewController
- (IBAction)clikcSelectCategory:(UIButton *)sender {
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
	
	[self.view addSubview:_dataPicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    CGRect rect=[textView convertRect: textView.bounds toView:APP_DELEGATE.window];
    if ((_mainScrollView.contentOffset.y  + rect.origin.y - 200) > 0) {
        [self.mainScrollView setContentOffset:CGPointMake(0, _mainScrollView.contentOffset.y  + rect.origin.y - 200) animated:YES];
    }
    
    

}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    
    CGRect rect=[textField convertRect: textField.bounds toView:APP_DELEGATE.window];
    if ((_mainScrollView.contentOffset.y  + rect.origin.y - 200) > 0) {
        [self.mainScrollView setContentOffset:CGPointMake(0, _mainScrollView.contentOffset.y  + rect.origin.y - 200) animated:YES];
    }
    
    return YES;
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
