//
//  ShoppingCartGuiGeTableViewCell.h
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Goods;

@protocol ShoppingCartGuiGeTableViewCellDelegate <NSObject>


-(void)ShoppingCartGuiGeTableViewCellchangeNumberWith:(NSString *)count withRect:(CGRect) rect withIndexPath:(NSIndexPath *)indexPath;


@end
@interface ShoppingCartGuiGeTableViewCell : UITableViewCell
/**
 <#Description#>
 */
@property (nonatomic ,strong) NSIndexPath *indexPath;

/**
 <#Description#>
 */
@property (nonatomic ,strong) Goods * dataSourse;

@property (nonatomic ,copy) void(^selectShoppingCartGuiGeBlock)(NSIndexPath *indexPath);

@property (nonatomic ,weak ) id <ShoppingCartGuiGeTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *guigeSelectButton;

- (IBAction)clickGuigeSelectButton:(UIButton *)sender;
@end
