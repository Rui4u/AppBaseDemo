//
//  NewCustomAlertView.m
//  HZAgentiOSClient
//
//  Created by sharui on 2017/8/23.
//  Copyright © 2017年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "NewCustomAlertView.h"

@interface AlertView : UIView

/**
 顶部titleView
 */
@property (nonatomic ,strong ) UIView * topTitleView;

/**
 内容view
 */
@property (nonatomic ,strong ) UIView * contentView;

/**
 标题label
 */
@property (nonatomic ,strong ) UILabel * titleLabel;
/**
 底部点击事件view
 */
@property (nonatomic ,strong ) UIView * bottomTargetView;

/**
 高度
 */
@property (nonatomic ,assign ) CGFloat contentViewHeight;

/**
 按钮数组
 */
@property (nonatomic ,strong ) NSArray * buttonTitleArray;

/**
 按钮颜色
 */
@property (nonatomic ,strong ) NSArray * buttonColorArray;

/**
 记录最后一个按钮
 */
@property (nonatomic ,strong ) UIButton * lastButton;

@property (nonatomic ,copy ) void(^clickBlock)(NSInteger index);
- (void)reloadeData;
@end
@implementation AlertView

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.layer.masksToBounds = YES;
		self.layer.cornerRadius = 5;
		[self setUpUI];
	}
	return self;
}


- (void)setUpUI {
	
	_topTitleView = ({
		UIView * topView = [[UIView alloc] init];
		topView.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
		_titleLabel = [UILabel creatLabelWithText:@"" FontOfSize:14 textColor:@"333333"];
		_titleLabel.textAlignment = NSTextAlignmentCenter;
		[topView addSubview:_titleLabel];
		
		[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(topView.mas_top);
			make.bottom.equalTo(topView.mas_bottom);
			make.left.equalTo(topView.mas_left);
			make.right.equalTo(topView.mas_right);
		}];
		
		topView;
	});
	_contentView = ({
		UIView * contentView = [[UIView alloc] init];
		contentView.backgroundColor = [UIColor whiteColor];
		contentView;
	});
	_bottomTargetView = ({
		UIView * bottomTargetView = [[UIView alloc] init];
		bottomTargetView.backgroundColor = [UIColor whiteColor];
		bottomTargetView;
	});
	
	
	[self addSubview:_topTitleView];
	[self addSubview:_contentView];
	[self addSubview:_bottomTargetView];
	
	
	
}
- (void)reloadeData {

	[self initAllButtonsLeftButtonTitleColor:@"333333"
					   rightButtonTitleColor:@"ffffff"
							 buttonTitleFont:16];
}
- (void)layoutSubviews {
	[super layoutSubviews];
	
	[_topTitleView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.mas_top);
		make.left.equalTo(self.mas_left);
		make.right.equalTo(self.mas_right);
		make.height.mas_equalTo(40);
	}];
	
	[_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(_topTitleView.mas_bottom);
		make.left.equalTo(self.mas_left);
		make.right.equalTo(self.mas_right);
		make.bottom.equalTo(_bottomTargetView.mas_top);
		make.height.mas_equalTo(_contentViewHeight);
	}];
	
	[_bottomTargetView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.bottom.equalTo(self.mas_bottom);
		make.left.equalTo(self.mas_left);
		make.right.equalTo(self.mas_right);
		make.height.mas_equalTo(44);
	}];

	self.center = super.center;

}

#pragma mark - 处理弹窗两个按钮
- (void)initAllButtonsLeftButtonTitleColor:(NSString *)leftButtonTitleColor
					 rightButtonTitleColor:(NSString *)rightButtonTitleColor
						   buttonTitleFont:(float)buttonTitleFont

{
	NSArray * buttonTitleColorArr = self.buttonColorArray;

	if (_buttonTitleArray.count > 0)
	{
		for (int i= 0; i<_buttonTitleArray.count; i++)
		{
			NSInteger index = [_buttonTitleArray indexOfObject:_buttonTitleArray[i]];
			
			UIButton *button = [[UIButton alloc] init];
			button.titleLabel.font = [UIFont systemFontOfSize:buttonTitleFont];
			button.tag = i +1000;
			[button setTitle:_buttonTitleArray[i] forState:UIControlStateNormal];
			[button setTitleColor:[UIColor colorWithHexString:buttonTitleColorArr[i]] forState:UIControlStateNormal];
			[button addTarget:self action:@selector(buttonWithPressed:) forControlEvents:UIControlEventTouchUpInside];
			[_bottomTargetView addSubview:button];
			
			
			[button mas_updateConstraints:^(MASConstraintMaker *make) {
				
				make.top.equalTo(_bottomTargetView.mas_top);
				make.bottom.equalTo(_bottomTargetView.mas_bottom);
				
				if (_lastButton) {
					make.left.equalTo(_lastButton.mas_right);
					make.width.equalTo(_lastButton.mas_width);
				}else {
					make.left.equalTo(_bottomTargetView.mas_left);
				}
				
				if (i == _buttonTitleArray.count- 1) {
					make.right.equalTo(_bottomTargetView.mas_right);
				}
			}];
			
			_lastButton = button;
		
			
			
			if (index < _buttonTitleArray.count - 1)
			{
				UIView *verticalSeperatorView = [[UIView alloc] init];
				verticalSeperatorView.backgroundColor = [UIColor colorWithHexString:@"d3d3d3"];
				[_bottomTargetView addSubview:verticalSeperatorView];
				
				[verticalSeperatorView mas_updateConstraints:^(MASConstraintMaker *make) {
					make.left.equalTo(button.mas_right);
					make.width.mas_equalTo(1);
					make.height.mas_equalTo(30);
					make.centerY.equalTo(button.mas_centerY);
					
				}];
			}
		}
	}
}

- (void)buttonWithPressed:(UIButton *)sender {

	
	NSInteger tag = sender.tag - 1000;
	if (self.clickBlock) {
		self.clickBlock(tag);
	}
}

@end




@interface NewCustomAlertView ()

@property (nonatomic ,strong ) AlertView * alertView;

@end
@implementation NewCustomAlertView

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
		self.backgroundColor = [UIColor colorWithWhite:0 alpha:.3];
		
		[APP_DELEGATE.window addSubview:self];
		
		_alertView = [[AlertView alloc] init];
		_alertView.center = self.center;
		[self addSubview:_alertView];
		
	}
	return self;
}
- (void)reloadData {
	
	
	_alertView.contentViewHeight = self.contentViewHeight;
	_alertView.titleLabel.text = self.titleLabelText;
	_alertView.buttonColorArray = self.buttonColorArray;
	[_alertView.contentView addSubview:self.contentView];
	[self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(self.contentView.height);
		make.width.mas_equalTo(self.contentView.width);
		make.centerY.equalTo(_alertView.contentView.mas_centerY);
		make.centerX.equalTo(_alertView.contentView.mas_centerX);
	}];

	self.contentView.center = _alertView.contentView.center;
	_alertView.buttonTitleArray = self.buttonTitleArray;
	[_alertView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.width.mas_equalTo(self.alertViewWidth);
		make.centerX.equalTo(self.mas_centerX);
		make.centerY.equalTo(self.mas_centerY);
	}];
	[_alertView reloadeData];
	__weak typeof(self)weakSelf = self;
	
	_alertView.clickBlock = ^(NSInteger index) {
		weakSelf.clickBlock(index);
		[weakSelf alertDisMiss];
	};
}


#pragma mark - 弹窗消失的方法
- (void) alertDisMiss
{
	NSLog(@">>>>>>>>>>>>关闭<<<<<<<<<<<<");
	[UIView animateWithDuration:.3 animations:^{
		self.alpha = 0;
	}
					 completion:^(BOOL finished)
	 {
		 [self removeFromSuperview];
	 }];
	
}
@end
