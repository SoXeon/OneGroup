//
//  DPBuyDock.m
//  一团
//
//  Created by DP on 14-5-22.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPBuyDock.h"
#import "DPDeal.h"
#import "UIImage+DP.h"
#import "DPLineLabel.h"

@implementation DPBuyDock

-(void)setDeal:(DPDeal *)deal
{
    _deal = deal;
    _listPrice.text = [NSString stringWithFormat:@"%@ 元",deal.list_price_text];
    _currentPrice.text = deal.current_price_text;
}

- (void)buy {
    NSString *ID = [_deal.deal_id substringFromIndex:[_deal.deal_id rangeOfString:@"-"].location +1];
    
    NSString *url = [NSString stringWithFormat:@"http://o.p.dianping.com/order/d%@",ID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

+(id)buyDock
{
    return [[NSBundle mainBundle] loadNibNamed:@"DPBuyDock" owner:nil options:nil][0];
}

- (void)drawRect:(CGRect)rect
{
    [[UIImage resizedImage:@"bg_buyBtn.png"] drawInRect:rect];
}
@end
