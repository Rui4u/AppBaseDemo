//
//  AppProdcutSelectSpecificationCell.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/1.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "AppProdcutSelectSpecificationCell.h"
#import "SelectSpecificationView.h"
#import "GetSelectedProductModel.h"
@interface AppProdcutSelectSpecificationCell () <SelectSpecificationViewDelegate>
/**
 <#Description#>
 */
@property (nonatomic ,strong) SelectSpecificationView * selectSpecificationView;
@end
@implementation AppProdcutSelectSpecificationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {

    SelectSpecificationView * selectSpecificationView = [[SelectSpecificationView alloc] initWithFrame:CGRectMake(15,0,SCREEN_WIDTH - 80 - 15,66)];
    self.selectSpecificationView = selectSpecificationView;
    selectSpecificationView.index = self.indexPath.row;
    selectSpecificationView.delegate = self;
    [self.contentView addSubview:selectSpecificationView];
    

    UIView *imaginaryLine= [[UIView alloc] initWithFrame:CGRectMake(15,66,SCREEN_WIDTH - 80 - 15,.5)];
    [UIView drawDashLine:imaginaryLine lineLength:4 lineSpacing: 2 lineColor:[UIColor colorWithHexString:Main_Line_Gary_Color]];
    [self.contentView addSubview:imaginaryLine];
}

-(void)selectSpecificationWithIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(selectSpecificationWithIndexPath:)]) {
        
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:self.indexPath.section];
        [self.delegate selectSpecificationWithIndexPath:indexPath];
    }

}
- (void)setDataSourse:(Goods *)dataSourse {
    _dataSourse = dataSourse;
    
   
    self.selectSpecificationView.totolPriceLabel.text = [NSString stringWithFormat:@"￥%@/%@(%@斤)",dataSourse.guige.firstObject.currentPrice,dataSourse.baseSpec,dataSourse.guige[self.indexPath.row].totalWeight];
    
    self.selectSpecificationView.averagePrice.text = [NSString stringWithFormat:@"￥%@元/斤",dataSourse.guige[self.indexPath.row].avgPrice];

    
    
    if ([dataSourse.discount isEqualToString:@"1"]) {
        self.selectSpecificationView.showDisCountView = YES;
    }else {
        self.selectSpecificationView.showDisCountView = NO;
    }
    self.selectSpecificationView.carGoodsNum = dataSourse.guige[self.indexPath.row].carGoodNum;
	
    
}


- (void)changeProcutNumberBagWith:(NSString *)count with:(NSInteger) row withRect:(CGRect)rect{
    [self.delegate changeProcutNumberBagWithCount:count withIndexPath:[NSIndexPath indexPathForRow:row inSection:self.indexPath.section] withRect:rect];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
