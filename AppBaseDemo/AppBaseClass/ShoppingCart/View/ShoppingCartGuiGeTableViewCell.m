//
//  ShoppingCartGuiGeTableViewCell.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ShoppingCartGuiGeTableViewCell.h"
#import "SelectAddView.h"
@interface ShoppingCartGuiGeTableViewCell()<SelectAddViewDelegate>

@property (nonatomic ,strong) SelectAddView * selectAddView;

@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *guigeSelectButton;
@property (weak, nonatomic) IBOutlet UILabel *averagePriceLabel;



@end
@implementation ShoppingCartGuiGeTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    _selectAddView = ({
        SelectAddView * selectAddView = [[NSBundle mainBundle] loadNibNamed:@"SelectAddView" owner:self options:nil].firstObject;
        selectAddView.delegate = self;
        selectAddView.isDiscount = NO;
        selectAddView;
    });
    
    [self.contentView addSubview:_selectAddView];
    
    [_selectAddView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.size.mas_offset(CGSizeMake(90, 30));
    }];
}

- (IBAction)clickGuigeSelectButton:(UIButton *)sender {
    sender.selected = !sender.selected;
}
#pragma - mark - d
-(void)changeNumberWith:(NSString *)count withRect:(CGRect) rect{

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
