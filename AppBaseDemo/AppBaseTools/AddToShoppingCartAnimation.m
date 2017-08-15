//
//  AddToShoppingCartAnimation.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "AddToShoppingCartAnimation.h"
@interface AddToShoppingCartAnimation ()<CAAnimationDelegate>
@property (nonatomic ,strong ) UIBezierPath* aPath;

@property (nonatomic ,strong ) UIView * animationView;
@property (nonatomic ,strong ) CAKeyframeAnimation *animation;
@end
@implementation AddToShoppingCartAnimation
static id instance;

+ (instancetype)sharedAnimation {
	
	static dispatch_once_t onceToken;
//	dispatch_once(&onceToken, ^{
		instance = [[self alloc] init];
		[instance setSubView];
//	});
	return instance;
}

- (void)setSubView {
	_aPath = ({
		//创建一条贝塞尔
		UIBezierPath* aPath = [UIBezierPath bezierPath];
		aPath.lineWidth = 5.0;//宽度
		aPath.lineCapStyle = kCGLineCapRound;  //线条拐角
		aPath.lineJoinStyle = kCGLineJoinRound;  //终点处理
		//	[aPath stroke];
		aPath;
	});
	

	
	_animation = ({
		CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
		animation.delegate = self;
		// 动画时间间隔
		animation.duration = 1;
		// 重复次数为最大值
		animation.repeatCount = 1;
		animation.removedOnCompletion = NO;
		animation.fillMode = kCAFillModeForwards;
		animation;
	});


}
- (void)animationWith:(UIView *)view  andPoint:(CGPoint)startPorin andEndPoint:(CGPoint)endPoint{

	
	//起始点
	[_aPath moveToPoint:startPorin];
	//添加两个控制点
	[_aPath addQuadCurveToPoint:endPoint controlPoint:CGPointMake(endPoint.x,startPorin.y)];
	//划线
	_animationView = ({
		UIView *heart = [[UIView alloc] init];
		heart.frame = CGRectMake(0, 0, 5, 5);
		heart.layer.masksToBounds =YES;
		heart.layer.cornerRadius = 2.5;
		heart.backgroundColor = [UIColor redColor];
		heart;
	});
	[view addSubview:_animationView];
	// 设置动画的路径为心形路径
	_animation.path = _aPath.CGPath;
	// 将动画添加到动画视图上
	[_animationView.layer addAnimation:_animation forKey:@"qwe"];

}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {

	[_animationView removeFromSuperview];
	[_animationView.layer removeAnimationForKey:@"qwe"];
	_animationView = nil;
	_animation = nil;
	
}
- (void)dealloc {

}
@end
