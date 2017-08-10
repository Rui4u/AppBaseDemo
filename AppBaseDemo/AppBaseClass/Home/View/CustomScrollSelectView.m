//
//  CustomScrollSelectView.h
//  HZAgentiOSClient
//
//  Created by sharui on 2017/6/7.
//  Copyright © 2017年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "CustomScrollSelectView.h"
#define LabelWidth WIDTH_AUTO(72)
@interface CustomScrollSelectView()

//改变的蓝条
@property (nonatomic,strong) UIView *changeView;

//上次的Lable
@property (nonatomic,strong) UILabel *oldLable;

@property (nonatomic,assign) NSInteger arrayNumber;

@property (nonatomic ,strong ) UIScrollView * bgScrollView;

/**
 记录最后一个坐标
 */
@property (nonatomic ,assign ) NSInteger lastX;
/**
 按钮集合
 */
@property (nonatomic ,strong ) NSMutableArray * buttonArray;

@property (nonatomic ,assign ) BOOL canClick;
@end


@implementation CustomScrollSelectView
- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.bgScrollView.frame = self.bounds;
	}
	return self;
}
- (void)setFrame:(CGRect)frame {
	
	[super setFrame:frame];
	self.bgScrollView.frame = self.bounds;
}

#pragma mark - 创建UI
- (void)reloadeData
{
	for (UIView * view in self.bgScrollView.subviews) {
		[view removeFromSuperview];
	}
	
	NSInteger number = self.dataSourse.count;
	
	self.arrayNumber = number;
	
	self.buttonArray = [NSMutableArray arrayWithCapacity:self.dataSourse.count];
    _lastX = 0;
	
	for (NSInteger i = 0; i < self.dataSourse.count; i++) {
		
		UIView *productTypeView = [[UIView alloc] initWithFrame:CGRectMake(_lastX, 0, LabelWidth, 44)];
		productTypeView.tag = 1000 + i;
        productTypeView.backgroundColor = [UIColor clearColor];
		[self.buttonArray addObject:productTypeView];
		//文字
		UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, productTypeView.width, 44)];
		
		lable.font = [UIFont systemFontOfSize:14];
		
		lable.textColor = (i == 0)?self.textSelectColor:self.textColor;
		
		lable.textAlignment = NSTextAlignmentCenter;
		
        lable.backgroundColor = [UIColor clearColor];
		
		lable.text = (NSString *)self.dataSourse[i];
		
		//根据字大小 设置width  间隔为7
		CGRect rect = lable.frame;
		[lable sizeToFit];
		CGFloat width = lable.width;
		lable.frame = rect;
		lable.width = width;
		productTypeView.width = lable.width + WIDTH_AUTO(14);
		lable.x = WIDTH_AUTO(7);
		if (IS_IPHONE_6_PLUS) {
			productTypeView.width = lable.width + 20;
			lable.x = 10;
		}
		_lastX = CGRectGetMaxX(productTypeView.frame);
		
		
		lable.tag = 999;
		
		[productTypeView addSubview:lable];
		
		i == 0?self.oldLable = lable:nil;
		
		productTypeView.userInteractionEnabled = YES;
		
		productTypeView.tag = 1000 + i;
		
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapClick:)];
		
		[productTypeView addGestureRecognizer:tap];
		
		[self.bgScrollView addSubview:productTypeView];
		
	}
	self.bgScrollView.contentSize = CGSizeMake( _lastX , 0);
	self.canClick = YES;
	
	[self.bgScrollView addSubview:self.changeView];
	
}
#pragma mark -点击不同类型时触发

- (void)onTapClick:(UITapGestureRecognizer *)sender
{
	
	if (_lastX > self.width) {
		//选中居中
		if (sender.view.centerX > self.width/2) {
			
			[self.bgScrollView setContentOffset: CGPointMake(sender.view.centerX - self.width/2, 0) animated:YES];
			
		}else  {
			
			[self.bgScrollView setContentOffset: CGPointMake(0, 0) animated:YES];
		}
		if (sender.view.centerX - self.width/2 >= _lastX - self.width) {
			
			[self.bgScrollView setContentOffset: CGPointMake(_lastX - self.width, 0) animated:YES];;
		}
	}
	
	
	

	[UIView animateWithDuration:0.3 animations:^{
		
		self.changeView.centerX = sender.view.centerX;
		
	}];
	
	self.oldLable.textColor = self.textColor;
	
	UILabel *lable = [sender.view viewWithTag:999];
	
	lable.textColor = self.textSelectColor;
	
	
	if (self.canClick) {
		if([self.delegate respondsToSelector:@selector(customScrollSelectView:didSelectWithProductTypeModel:)]){
			
			[self.delegate customScrollSelectView:self didSelectWithProductTypeModel:sender.view.tag - 1000];
		}
	}
	
	
	self.oldLable = lable;
}
#pragma mark - 懒加载
- (UIView *)changeView
{
	
	if(!_changeView){
		
		_changeView = [[UIView alloc] initWithFrame:CGRectMake(12,42, LabelWidth - 24, 2)];
		_changeView.backgroundColor = self.textSelectColor;
		
	}
	
	return _changeView;
}
- (UIScrollView *)bgScrollView {
	if (_bgScrollView == nil) {
		_bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
		_bgScrollView.showsVerticalScrollIndicator = NO;
		_bgScrollView.showsHorizontalScrollIndicator = NO;
		[self addSubview:_bgScrollView];
	}
	return _bgScrollView;
}



- (void)selectSwitchButtonAtIndex:(NSInteger) index withClick:(BOOL)canClick{
	self.canClick = canClick;
	[self onTapClick: ((UIView *)self.buttonArray[index]).gestureRecognizers.firstObject];
	self.canClick = YES;
}


- (UIColor *)textSelectColor {
	if (_textSelectColor == nil) {
		return kPLRGB_16(0X22BC22);//22BC22
	}else {
		return _textSelectColor;
	}

}

- (UIColor *)textColor {
	if (_textColor == nil) {
		return [UIColor whiteColor];
	}else {
		return _textColor;
	}
}

@end
