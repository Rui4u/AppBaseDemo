//
//  OrderDetailModel.m
//  AppBaseDemo
//
//  Created by sharui on 2017/8/18.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "OrderDetailModel.h"

@implementation OrderDetailsGoodsSpec

@end
@implementation OrderDetailsGoods
+ (NSDictionary *)replacedKeyFromPropertyName{
	return @{@"goodsId" : @"id"};
}
+ (NSDictionary *)objectClassInArray{
	return @{
			 @"goodsSpec":@"OrderDetailsGoodsSpec"
			 };
}
@end
@implementation OrderDetails
- (NSString *)time {
    // 格式化时间
    
    
    return [self dataFormat:_time];
}
- (NSString *)okTime {
    return [self dataFormat:_okTime];
}

- (NSString *)yujiTime {
    return [self dataFormat:_yujiTime];
    
    
}

- (NSString *)dataFormat:(NSString *)string{
    if (string.length == 0) {
        return @"";
    }
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[_time doubleValue]];
    return  [formatter stringFromDate:date];
    
}
+ (NSDictionary *)replacedKeyFromPropertyName{
	return @{@"orderDetailsId" : @"id"};
}
+ (NSDictionary *)objectClassInArray{
	return @{
			 @"goods":@"OrderDetailsGoods"
			 };
}
@end

@implementation OrderDetailModel

@end
