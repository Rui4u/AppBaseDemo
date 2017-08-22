//
//  SRCustomTabbarView.m
//    SRiOSClient
//
//  Created by sharui on 2017/4/11.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "SRCustomTabBarView.h"
#import "LCVerticalBadgeBtn.h"
#define iconButtonTag 10000

@interface SRCustomTabBarView()<CAAnimationDelegate>

/**
 记录button
 */
@property (nonatomic ,strong ) UIButton * lastButton;

/**
 当前button
 */
@property (nonatomic ,strong ) UIButton * currentButton;
/**
 滑动View
 */
@property (nonatomic ,strong ) UIImageView * scrollImageView;

/**
 buttonLabel 数组
 */
@property (nonatomic ,strong ) NSMutableArray <UILabel *>* buttonLabelArray;

@property (nonatomic ,strong ) NSArray * imageInArray;
@property (nonatomic) BOOL animating;

@end
@implementation SRCustomTabBarView

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self privateSetUpUI];
	}
	return self;
}

#pragma mark - 设置UI
- (void) privateSetUpUI {
	
    UIView * lineView  = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:Main_Line_Gary_Color];
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
    }];
    
	self.frame = CGRectMake(0, SCREEN_HEIGHT -  49, SCREEN_WIDTH, 49);
	self.backgroundColor = [UIColor whiteColor];
	NSArray * imageArray = @[@"tabBarIcon_homeNormal",@"tabBarIcon_MineNormal",@"tabBarIcon_ChannelNormal",@"tabBarIcon_moreNormal",@"tabBarIcon_moreNormal"];
	NSArray * imageSelectedArray = @[@"tabBarIcon_homeSelecetd",@"tabBarIcon_MineSelecetd",@"tabBarIcon_ChannelSelected",@"tabBarIcon_moreSelecetd",@"tabBarIcon_moreSelecetd"];

	NSArray * nameArray = @[@"首页",@"产品中心",@"常用清单",@"购物车",@"我的"];
	
	for (int  i = 0; i < imageArray.count; i++ ) {
		
		CGFloat width = SCREEN_WIDTH / imageArray.count;
		
		LCVerticalBadgeBtn *iconButton = [[LCVerticalBadgeBtn alloc] initWithFrame:CGRectMake(width * i, 0, width, self.height)];
		iconButton.imageEdgeInsets = UIEdgeInsetsMake(-5, 0, 5, 0);
		iconButton.tag = iconButtonTag + i;
        
		[iconButton setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
		[iconButton setImage:[UIImage imageNamed:imageSelectedArray[i]] forState:UIControlStateSelected];
		[iconButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		iconButton.titleLabel.font = [UIFont systemFontOfSize:12];
		[iconButton addTarget:self action:@selector(selectCustomTabBarButton:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:iconButton];
        if ( i == 3) {
            self.shoppingCartButton = iconButton;
        }
    
		UILabel * iconButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, iconButton.height -15, iconButton.width, 15)];
		iconButtonLabel.textAlignment = NSTextAlignmentCenter;
		iconButtonLabel.font = [UIFont systemFontOfSize:10];
		iconButtonLabel.textColor = [UIColor colorWithHexString:Main_Font_Black_Color];
		iconButtonLabel.text = nameArray[i];
		[iconButton addSubview:iconButtonLabel];
		
		[self.buttonLabelArray addObject:iconButtonLabel];
		
		if (i == 0) {
			self.scrollImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_imageInArray[i]]];
			
			[self.scrollImageView sizeToFit];
			self.scrollImageView.center = CGPointMake(iconButton.center.x, iconButton.center.y - 5);
			[self addSubview:self.scrollImageView];
			iconButtonLabel.textColor = [UIColor orangeColor];
		}
	}
}

- (void)setlectNomalTabBar {
	UIButton * button = [self viewWithTag:iconButtonTag];
	[self selectCustomTabBarButton:button];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
	_selectedIndex = selectedIndex;
	
	UIButton * button = [self viewWithTag:iconButtonTag + selectedIndex];
	[self selectCustomTabBarButton:button];
}
- (void)selectCustomTabBarButton:(UIButton *)sender {
	if (self.animating) {
		return;
	}
    sender.selected = YES;
	self.currentButton = sender;
	
	if (_lastButton == nil ) {
		
		if ([self.delegate respondsToSelector:@selector(selectCustomTabBarAtCurrentIndex:withLastIndex:)]) {
			
			NSInteger currentTag = _currentButton.tag - iconButtonTag;
            NSInteger lastTag = 0;
            
			self.buttonLabelArray[currentTag].textColor = [UIColor orangeColor];
			[self.delegate selectCustomTabBarAtCurrentIndex:currentTag withLastIndex:lastTag];
			_currentButton.selected = YES;
			_lastButton = sender;
			
			
		}
		return;
	}
	if ([_lastButton isEqual:_currentButton]) {
		return;
	}
	
    
				
	_lastButton.selected = NO;
    
    NSInteger currentTag = _currentButton.tag - iconButtonTag;
    NSInteger lastTag = _lastButton.tag - iconButtonTag;
    if ([self.delegate respondsToSelector:@selector(selectCustomTabBarAtCurrentIndex:withLastIndex:)]) {
        [self.delegate selectCustomTabBarAtCurrentIndex:currentTag withLastIndex:lastTag];
        _currentButton.selected = YES;
		self.buttonLabelArray[lastTag].textColor = [UIColor colorWithHexString:Main_Font_Black_Color];
		self.buttonLabelArray[currentTag].textColor = [UIColor orangeColor];
		
    }
    _lastButton = _currentButton;
	
}

- (void)selectButtonAnimation:(UIButton *)sender{
	
	
	
	CGFloat imageViewY = CGRectGetMidY(sender.frame) + 9;

	[UIView animateWithDuration:.1 animations:^{
		self.scrollImageView.height = 2;
		self.scrollImageView.width = 2;
		self.scrollImageView.center = CGPointMake(_lastButton.center.x, _lastButton.center.y - 5);
		self.scrollImageView.y = imageViewY +1;
		
	} completion:^(BOOL finished) {
		
		_scrollImageView.image = [UIImage imageNamed:self.imageInArray[_currentButton.tag - iconButtonTag]];
		_scrollImageView.alpha = 0;
		self.scrollImageView.size = CGSizeZero;
		self.scrollImageView.center = CGPointMake(_currentButton.center.x, _currentButton.center.y - 5);
		
		CAShapeLayer *shapeLayer = [CAShapeLayer layer];
		[shapeLayer setValue: @"loadingView" forKey: @"layerName"];
		
		//使用贝塞尔曲线先把整个路径画出来
		UIBezierPath *path = [UIBezierPath bezierPath];
		[path moveToPoint: CGPointMake(_lastButton.center.x,imageViewY)];
		[path addLineToPoint:CGPointMake( _currentButton.center.x,imageViewY)];
		
		
		shapeLayer.path = path.CGPath;
		shapeLayer.frame = self.bounds;
		shapeLayer.strokeColor = [UIColor colorWithHexString:@"f66144"].CGColor;
		shapeLayer.fillColor = [UIColor clearColor].CGColor;
		shapeLayer.lineWidth = 2.f;
		
		[self.layer addSublayer: shapeLayer];
		
		
		CABasicAnimation *animationStart = [CABasicAnimation animation];
		animationStart.keyPath = @"strokeEnd";
		animationStart.duration = .2f;
		animationStart.fromValue = @(0);
		animationStart.toValue = @(1);
		animationStart.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
		
		//strokeStart动画，fromValue: 开始画线的点 toValue: 画线结束的点
		CABasicAnimation *animationEnd = [CABasicAnimation animation];
		animationEnd.keyPath = @"strokeStart";
		animationEnd.beginTime = 0.1f;
		animationEnd.duration = 0.3f;
		animationEnd.fromValue = @(0);
		animationEnd.toValue = @(1);
		animationEnd.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut];
		
		CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
		animationGroup.duration = .4f;
		animationGroup.animations = @[animationStart, animationEnd];
		animationGroup.delegate = self;
		animationGroup.fillMode = kCAFillModeForwards;
		animationGroup.removedOnCompletion = NO;
		[animationGroup setValue: @"loadingAnimation" forKey: @"animationName"];
		[shapeLayer addAnimation: animationGroup forKey: nil];

		
		
		[UIView animateWithDuration:.5 delay:0.2f options:UIViewAnimationOptionCurveEaseInOut animations:^{
			
			_scrollImageView.alpha = 1;
			[_scrollImageView sizeToFit];
			self.scrollImageView.center = CGPointMake(_currentButton.center.x, _currentButton.center.y - 5);
			
		} completion:nil];
	}];
}
- (void)animationDidStart:(CAAnimation *)anim {
	self.animating = YES;
	
	NSInteger currentTag = _currentButton.tag - iconButtonTag;
	NSInteger lastTag = _lastButton.tag - iconButtonTag;
	
	if ([self.delegate respondsToSelector:@selector(selectCustomTabBarAtCurrentIndex:withLastIndex:)]) {
		[self.delegate selectCustomTabBarAtCurrentIndex:currentTag withLastIndex:lastTag];
		_currentButton.selected = YES;
	}
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
	
	if ([[anim valueForKey: @"animationName"] isEqualToString: @"loadingAnimation"]) {
		for (CALayer *layer in self.layer.sublayers) {
			if ([[layer valueForKey: @"layerName"] isEqualToString: @"loadingView"]) {
				[layer removeFromSuperlayer];
				self.animating = NO;
				
				NSInteger currentTag = _currentButton.tag - iconButtonTag;
				NSInteger lastTag = _lastButton.tag - iconButtonTag;
				self.buttonLabelArray[currentTag].textColor = [UIColor orangeColor];
				self.buttonLabelArray[lastTag].textColor = [UIColor colorWithHexString:Main_Font_Black_Color];
				_lastButton = _currentButton;

			}
		}
	}
	
}

- (NSMutableArray <UILabel *>*)buttonLabelArray {
	if (!_buttonLabelArray) {
		_buttonLabelArray = [NSMutableArray arrayWithCapacity:4];
	}
	return _buttonLabelArray;

}
@end
