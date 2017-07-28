//
//  NSMutableAttributedString+SRSpecial.m
//  HZPrivateEquityiOSClient
//
//  Created by ZhentaiNing_Huizhong on 16/10/10.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "NSMutableAttributedString+SRSpecial.h"

@implementation NSMutableAttributedString (SRSpecial)

+ (NSMutableAttributedString *)setAttributeString : (NSString *)txt
                                             font : (CGFloat)font
                                        textcolor : (UIColor*)color
                                      secondcolor : (UIColor*)scolor
                                       secondfont : (CGFloat)font2
{
    if (txt ==nil)
    {
        return nil;
    }
    
    NSArray * compentsArr = [txt componentsSeparatedByCharactersInSet:
                             [NSCharacterSet characterSetWithCharactersInString:@"{}"]];
    // NSLog(@"compentsArr %@", compentsArr);
    
    NSMutableArray * numbersArr = [NSMutableArray new];
    
    for (int i = 0 ; i < [compentsArr count]; i ++)
    {
        if (i % 2 !=0)
        {
            NSString * string = [compentsArr objectAtIndex:i];
            [numbersArr addObject:string];
        }
    }
    
    txt = [txt stringByReplacingOccurrencesOfString:@"{" withString:@""];
    txt = [txt stringByReplacingOccurrencesOfString:@"}" withString:@""];
    
    NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc] init];
    [ps setAlignment:NSTextAlignmentCenter];
    
    NSDictionary *attribs = @{
                              NSFontAttributeName:[UIFont systemFontOfSize:font],
                              NSParagraphStyleAttributeName:ps
                              ,NSForegroundColorAttributeName:scolor};
    
    NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:txt attributes:attribs];
    
    NSRange lastRange = NSMakeRange(0, [txt length]);
    
    for (int i = 0; i <[numbersArr count]; i ++)
    {
        NSString * str = [numbersArr objectAtIndex:i];
        //        NSLog(@"str = %@,text = %@",str,txt);
        NSRange range =[txt rangeOfString:str options:NSLiteralSearch range:lastRange];
        
        lastRange = NSMakeRange(range.location + range.length,[txt length] - range.location - range.length);
        
        [attributedText addAttribute:NSForegroundColorAttributeName value:color range:range];
        [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:range];
        if(i == 1)
        {
            [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font2] range:range];
            [attributedText addAttribute:NSForegroundColorAttributeName value:scolor range:range];
            
        }
        
        
    }
    return attributedText;

}




+ (NSMutableAttributedString *)setMoreAttributeString : (NSString *)txt
                                                 font : (CGFloat)font
                                            textcolor : (UIColor*)color
                                          secondcolor : (UIColor*)scolor
                                           secondfont : (CGFloat)font2
{
    if (txt ==nil)
    {
        return nil;
    }
    
    NSArray * compentsArr = [txt componentsSeparatedByCharactersInSet:
                             [NSCharacterSet characterSetWithCharactersInString:@"{}"]];
    // NSLog(@"compentsArr %@", compentsArr);
    
    NSMutableArray * numbersArr = [NSMutableArray new];
    
    for (int i = 0 ; i < [compentsArr count]; i ++)
    {
        if (i % 2 !=0)
        {
            NSString * string = [compentsArr objectAtIndex:i];
            [numbersArr addObject:string];
        }
    }
    
    txt = [txt stringByReplacingOccurrencesOfString:@"{" withString:@""];
    txt = [txt stringByReplacingOccurrencesOfString:@"}" withString:@""];
    
    NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc] init];
    [ps setAlignment:NSTextAlignmentCenter];
    
    NSDictionary *attribs = @{
                              NSFontAttributeName:[UIFont systemFontOfSize:font2],
                              NSParagraphStyleAttributeName:ps
                              ,NSForegroundColorAttributeName:scolor};
    
    NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:txt attributes:attribs];
    
    NSRange lastRange = NSMakeRange(0, [txt length]);
    
    for (int i = 0; i <[numbersArr count]; i ++)
    {
        NSString * str = [numbersArr objectAtIndex:i];
        //        NSLog(@"str = %@,text = %@",str,txt);
        NSRange range =[txt rangeOfString:str options:NSLiteralSearch range:lastRange];
        
        lastRange = NSMakeRange(range.location + range.length,[txt length] - range.location - range.length);
        
        [attributedText addAttribute:NSForegroundColorAttributeName value:color range:range];
        [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:range];
        
        
    }
    return attributedText;
    
}
@end
