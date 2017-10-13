//
//  AccountContentListCellTableViewCell.h
//  AppBaseDemo
//
//  Created by sharui on 2017/10/13.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountContentListCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic ,copy ) void (^submitButtonBlock)(NSString * name ,NSString *phone);

@end
