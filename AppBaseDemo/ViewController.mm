//
//  ViewController.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/7.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
	//创建一条贝塞尔
	UIBezierPath* aPath = [UIBezierPath bezierPath];
	
	aPath.lineWidth = 5.0;//宽度
	aPath.lineCapStyle = kCGLineCapRound;  //线条拐角
	aPath.lineJoinStyle = kCGLineJoinRound;  //终点处理
	//起始点
	[aPath moveToPoint:CGPointMake(20, 100)];
	//添加两个控制点
	[aPath addQuadCurveToPoint:CGPointMake(220, 100) controlPoint:CGPointMake(170, 0)];
	//划线
	[aPath stroke];
	
	UIView *heart = [[UIView alloc] init];
	heart.frame = CGRectMake(0, 0, 5, 5);
	heart.layer.masksToBounds =YES;
	heart.layer.cornerRadius = 2.5;
	
	[self.view addSubview:heart];
	heart.backgroundColor = [UIColor redColor];
	
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	animation.delegate = self;
	// 设置动画的路径为心形路径
	animation.path = aPath.CGPath;
	// 动画时间间隔
	animation.duration = .3f;
	// 重复次数为最大值
	animation.repeatCount = 1;
	animation.removedOnCompletion = NO;
	animation.fillMode = kCAFillModeForwards;
	// 将动画添加到动画视图上
	[heart.layer addAnimation:animation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {

	
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
