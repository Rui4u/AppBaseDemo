//
//  UIButton+SRButton.h
//  HZPrivateEquityiOSClient
//
//  Created by sharui on 16/10/9.
//  Copyright © 2016年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , ButtonColor)
{
    ButtonColorBlue,//蓝色
    ButtonColorRed,//红色
    ButtonColorGray,//灰色
    ButtonColorOrange,//橙色 颜色渐变
    ButtonColorBlueBorder,//蓝色边框
};

/**
 *       UIButton 类目
 */
@interface UIButton (SRButton)

//@property (nonatomic , assign) ButtonColor * _Nonnull type;

/**
 *  快速创建Button
 *
 *  @param frame  <#frame description#>
 *  @param title  <#title description#>
 *  @param target <#target description#>
 *
 *  @return <#return value description#>
 */
+ (UIButton * _Nonnull) quickCreateButtonWithFrame :(CGRect) frame
                                     title :(NSString * _Nonnull)title
                                 addTarget :(nullable id)target
                                    action :(nullable NSString * )action;

/**
 *  创建圆角Button
 *
 *  @param frame     <#frame description#>
 *  @param image     <#image description#>
 *  @param imageRect <#imageRect description#>
 *
 *  @return <#return value description#>
 */
+ (UIButton * _Nonnull) quickCreateRoundedButtonWithFrame : (CGRect ) frame
                                            image : (UIImage * _Nonnull) image
                                        imageRect : (CGRect)imageRect ;
/**
 *  添加图片button
 *
 *  @param rect      <#rect description#>
 *  @param image     <#image description#>
 *  @param imageRect <#imageRect description#>
 *
 *  @return <#return value description#>
 */
+ (UIButton * _Nonnull) quickCreateButtonWithImages:(CGRect)rect
                                              image:(UIImage* _Nonnull)image
                                          imageRect:(CGRect)imageRect ;

/**
 创建带边框、frame、背景色、title、titleColor、borderWidth、borderColor

 @param userInteractionEnabled <#userInteractionEnabled description#>
 @param frame                  <#frame description#>
 @param backgroundColor        <#backgroundColor description#>
 @param title                  <#title description#>
 @param titleColor             <#titleColor description#>
 @param borderWidth            <#borderWidth description#>
 @param borderColor            <#borderColor description#>

 @return <#return value description#>
 */
+ (UIButton * _Nonnull) creatAuthButtonWithUserInteractionEnabled:(BOOL)userInteractionEnabled
                                                    frame:(CGRect)frame
                                          backgroundColor:(NSString * _Nonnull)backgroundColor
                                                    title:(NSString *_Nonnull)title
                                               titleColor:(NSString *_Nonnull)titleColor
                                              borderWidth:(float)borderWidth
                                              borderColor:(NSString *_Nonnull)borderColor;



/**
 选择类button

 @param normailString  默认图片
 @param selectedString 选择图片
 @param title          名称
 @param titleColor     颜色
 @param foneSize       字体大小
 @param target         目标控制器
 @param action         响应方法

 @return <#return value description#>
 */
+ (UIButton * _Nonnull)creatSelectButtonWithNormalImage:(NSString *_Nullable)normailString
                                          selectedImage:(NSString *_Nullable)selectedString
                                                  title:(NSString *_Nullable)title
                                             titleColor:(NSString *_Nonnull)titleColor
                                               fontSize:(NSUInteger)foneSize
                                                 target:(id _Nullable)target
                                                 action:(NSString *_Nonnull)action;

/**
 左字右图

 @param btn <#btn description#>
 */
- (void)setImageToRight;

/**
 下子上图
 */
- (void)setImageToUp;


/**
 创建的底部的button

 @param frame           <#frame description#>
 @param backgroundImage <#backgroundImage description#>
 @param title           <#title description#>
 @param titleColor      <#titleColor description#>
 @param target          <#target description#>
 @param action          <#action description#>

 @return <#return value description#>
 */
+ (UIButton *_Nonnull) creatBottomButtonWithFrame:(CGRect)frame
                                  buttonColorType:(ButtonColor)buttonColorType
                                            title:(NSString *_Nonnull)title
                                       titleColor:(NSString *_Nonnull)titleColor
                                           target:(id _Nonnull)target
                                           action:(NSString *_Nonnull)action;

@end
