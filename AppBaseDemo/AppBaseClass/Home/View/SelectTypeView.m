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
@interface SelectTypeView ()<CustomScrollSelectViewDelegate>
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
		self.customScrollSelectView.delegate = self;
		self.customScrollSelectView.textColor = [UIColor blackColor];
	}
	return self;
}
- (void)customScrollSelectView:(CustomScrollSelectView *)customScrollSelectView
 didSelectWithProductTypeModel:(NSInteger)index
{

	if ([self.delegate respondsToSelector:@selector(didSelectWithProductTypeModel:)]) {
		[self.delegate didSelectWithProductTypeModel:index];
	}

}

- (void)setDataSourse:(NSArray *)dataSourse {

	self.customScrollSelectView.dataSourse = dataSourse;
	[self.customScrollSelectView reloadeData];

}
@end
