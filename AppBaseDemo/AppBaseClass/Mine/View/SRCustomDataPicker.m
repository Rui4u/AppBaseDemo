//
//  SRCustomDataPicker.m
//  HZAgentiOSClient
//
//  Created by sharui on 2017/6/10.
//  Copyright © 2017年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "SRCustomDataPicker.h"

#define Year_Component  0
#define Month_Component 1
#define TopView_Height  36
@interface SRCustomDataPicker()<UIPickerViewDataSource,UIPickerViewDelegate>

/**
 弹框页面
 */
@property (nonatomic ,strong ) UIButton * alertView;
/**
 顶部View
 */
@property (nonatomic ,strong ) UIView * topView;

/**
 
 */
@property (nonatomic ,strong ) UIPickerView * pickerView;

/**
 确认
 */
@property (nonatomic ,strong ) UIButton * confirmBtn;

/**
 取消
 */
@property (nonatomic ,strong ) UIButton * cancelBtn;

@end
@implementation SRCustomDataPicker
- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self addSubview:self.alertView];
		[self setSubViewFrame];
	}
	return self;
}
- (instancetype)init
{
	self = [super init];
	if (self) {
		self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 438/2);
		[self addSubview:self.alertView];
		[self setSubViewFrame];

	}
	return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	[self dismissView];
}
#pragma mark - 点击事件
- (void)BtnConfirm:(UIButton *)sender {
	
	
	for ( int i = 0; i < self.dataSourse.count; i ++) {
		NSInteger index = [self.pickerView selectedRowInComponent: i];
		NSString * name = [[self.dataSourse objectAtIndex:i] objectAtIndex:index];
		NSLog(@"%@",name);
	}
	[self dismissView];

}
- (void)BtnCancel:(UIButton *)sender {

	[self dismissView];
}

- (void)dismissView {
	
	[UIView animateWithDuration:.3 animations:^{
		_alertView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 438/2);
		
	} completion:^(BOOL finished) {
		self.hidden = YES;
	}];
}

#pragma mark-----pickerView------
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return self.dataSourse.count;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return self.dataSourse[component].count;
}
//设置分组的宽度
//-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
//	return  SCREEN_WIDTH/self.dataSourse.count;
//		return ;
//}

//每行文本
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
		return self.dataSourse[component][row];
}

//替换text居中 这里可以解决地址显示不全问题（根据需要自行定义，颜色，frame，font）
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
	UILabel * textLabel = [UILabel creatLabelWithText:@"" FontOfSize:13 textColor:@"333333"];
	
	textLabel.text = self.dataSourse[component][row];
	textLabel.textAlignment = NSTextAlignmentCenter;
	textLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH/self.dataSourse.count, 35);
	textLabel.backgroundColor = self.pickerView.backgroundColor;
	textLabel.adjustsFontSizeToFitWidth = YES;
	return textLabel;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
	return 35;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	
	for (int i = ((int)component + 1);i < self.dataSourse.count; i ++) {
		[self.pickerView selectRow:0 inComponent:i animated:YES];
	}
	
}
- (void)relodeData {
	[self.pickerView reloadAllComponents];
}


- (void)setSubViewFrame {
	self.hidden = YES;
	self.topView.frame = CGRectMake(0, 0, self.width, TopView_Height);
	self.pickerView.frame = CGRectMake(0, TopView_Height, self.width, self.height - TopView_Height);
	self.confirmBtn.frame = CGRectMake( self.width-_confirmBtn.width - 15,0, 32, TopView_Height);
	self.cancelBtn.frame = CGRectMake( 15,0, 32, TopView_Height);

}

- (UIButton *)alertView {
	if (_alertView == nil) {
		_alertView = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 438/2)];
		_alertView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
		[_alertView addSubview:self.topView];
		[_alertView addSubview:self.pickerView];
	}
	return _alertView;
}

- (UIPickerView *)pickerView {
	if (_pickerView == nil) {
		_pickerView = [[UIPickerView alloc] initWithFrame:self.alertView.bounds];
		_pickerView.delegate = self;
		_pickerView.dataSource = self;
	}
	return _pickerView;

}

- (UIView *)topView {
	if (_topView == nil) {
		_topView = [[UIView alloc] initWithFrame:self.bounds];
		_topView.backgroundColor = [UIColor whiteColor];
		[_topView addSubview:self.confirmBtn];
		[_topView addSubview:self.cancelBtn];
	}
	return _topView;
	
}

-(UIButton *)confirmBtn{
	if (!_confirmBtn) {
		_confirmBtn=[[UIButton alloc] init];
		[_confirmBtn setTitleColor:[UIColor colorWithHexString:@"1ebfe5"] forState:UIControlStateNormal];
		[_confirmBtn setTitleColor:[UIColor colorWithHexString:@"1ebgc5"] forState:UIControlStateHighlighted];
		_confirmBtn.titleLabel.font=[UIFont systemFontOfSize:15];
		[_confirmBtn setTitle:@"完成" forState:UIControlStateNormal];
		[_confirmBtn addTarget:self action:@selector(BtnConfirm:) forControlEvents:UIControlEventTouchUpInside];
	}
	return _confirmBtn;
}


-(UIButton *)cancelBtn{
	if (!_cancelBtn) {
		_cancelBtn=[[UIButton alloc] init];
		[_cancelBtn setTitleColor:[UIColor colorWithHexString:@"1ebfe5"] forState:UIControlStateNormal];
		[_cancelBtn setTitleColor:[UIColor colorWithHexString:@"1ebgc5"] forState:UIControlStateHighlighted];
		_cancelBtn.titleLabel.font=[UIFont systemFontOfSize:15];
		[_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
		[_cancelBtn addTarget:self action:@selector(BtnCancel:) forControlEvents:UIControlEventTouchUpInside];
	}
	return _cancelBtn;
}
- (void)showDataPicker {
	self.hidden = NO;
	self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
	self.backgroundColor = [UIColor colorWithHexString:@"000000" WithFloat:.4];
	[UIView animateWithDuration:.3 animations:^{
		_alertView.frame = CGRectMake(0, SCREEN_HEIGHT - 438/2, SCREEN_WIDTH, 438/2);

	}];
}

@end
