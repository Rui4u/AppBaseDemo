//
//  SelectTypeView.m
//  AppBaseDemo
//
//  Created by sharui on 2017/7/31.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "SelectTypeView.h"
#import "CustomScrollSelectView.h"
#import "SelectViewTitle.h"
@interface SelectTypeView ()
@property (nonatomic ,strong ) CustomScrollSelectView * customScrollSelectView;
@end
@implementation SelectTypeView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		
		SelectViewTitle * selectViewTitle = [[[NSBundle mainBundle] loadNibNamed:@"SelectViewTitle" owner:self options:nil] lastObject];
		selectViewTitle.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
		self.customScrollSelectView = [[CustomScrollSelectView alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 44)];
		[self addSubview:selectViewTitle];
		[self addSubview:self.customScrollSelectView];
		self.customScrollSelectView.dataSourse = @[@"肉禽类",@"新鲜蔬菜",@"米面粮油"];
		self.customScrollSelectView.textColor = [UIColor blackColor];
		[self.customScrollSelectView reloadeData];
		[self.customScrollSelectView selectSwitchButtonAtIndex:0];
	}
	return self;
}

@end
