//
//  FillOrderNomailCell.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/20.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "FillOrderNomailCell.h"
@interface FillOrderNomailCell ()
@property (weak, nonatomic) IBOutlet UILabel *leftLable;

@end
@implementation FillOrderNomailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDataSourse:(NSArray *)dataSourse {

    _leftLable.text = dataSourse.firstObject;
    _rightLable.text = dataSourse.lastObject;

}

@end
