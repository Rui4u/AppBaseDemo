//
//  ShoppingCartGuiGeTableViewCell.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/15.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ShoppingCartGuiGeTableViewCell.h"
#import "SelectAddView.h"
#import "ShoppingCartListModel.h"
@interface ShoppingCartGuiGeTableViewCell()<SelectAddViewDelegate>

@property (nonatomic ,strong) SelectAddView * selectAddView;

@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
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
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.size.mas_offset(CGSizeMake(105, 30));
    }];
}

- (IBAction)clickGuigeSelectButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.dataSourse.guige[_indexPath.row].selected = sender.selected;
    if (self.selectShoppingCartGuiGeBlock) {
        self.selectShoppingCartGuiGeBlock(self.indexPath);
    }
}
#pragma - mark - 添加购物车代理
-(void)changeNumberWith:(NSString *)count withRect:(CGRect) rect{
	self.dataSourse.guige[_indexPath.row].carGoodNum = count;
	
	if([self.delegate respondsToSelector:@selector(ShoppingCartGuiGeTableViewCellchangeNumberWith:withRect:withIndexPath:)]){
		[self.delegate ShoppingCartGuiGeTableViewCellchangeNumberWith:count withRect:rect withIndexPath:_indexPath];
	}
   
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataSourse:(Goods *)dataSourse {
    _dataSourse = dataSourse;
    
    Guige * guige = dataSourse.guige[_indexPath.row];
    
    _totalPriceLabel.text = [NSString stringWithFormat:@"{￥%@}/%@(%@斤)",guige.currentPrice,dataSourse.baseSpec,guige.totalWeight];
    _averagePriceLabel.text = [NSString stringWithFormat:@"￥%@/%@",guige.avgPrice,dataSourse.baseSpec];
    
    
    _totalPriceLabel.attributedText =
    [NSMutableAttributedString setAttributeString:_totalPriceLabel.text
                                             font:14
                                        textcolor:[UIColor colorWithHexString:Main_Font_Red_Color]
                                      secondcolor:[UIColor colorWithHexString:Main_Font_Gary_Color]
                                       secondfont:14];
    
    
    
    _selectAddView.isDiscount = NO;
    _selectAddView.carGoodsNum = guige.carGoodNum;
 
    _guigeSelectButton.selected = guige.selected;

}

@end
