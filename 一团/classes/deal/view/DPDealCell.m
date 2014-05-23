//
//  DPDealCell.m
//  一团
//
//  Created by DP on 14-5-18.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPDealCell.h"
#import "DPDeal.h"
#import "DPImageTool.h"

@implementation DPDealCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selected = YES;
    }
    return self;
}

-(void)setDeal:(DPDeal *)deal
{
    _deal = deal;
    
    //1.设置标签
    _desc.text = deal.desc;
    
    //2.下载图片
    [DPImageTool downloadImage:deal.image_url placeholder:[UIImage imageNamed:@"placeholder_deal.png"] imageView:_image];
    
    //3.购买人数
    [_purchaseCount setTitle:[NSString stringWithFormat:@"%d",deal.purchase_count] forState:UIControlStateNormal];
    
    //4.价格
    _price.text = deal.current_price_text;
    
    //5.标签
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *now = [fmt stringFromDate:[NSDate date]];
    
    //比较当前时间和取消时间
    NSString *icon = nil;
    if ([deal.publish_date isEqualToString:now]) {
      icon = @"ic_deal_new.png";
    } else if ([deal.purchase_deadline isEqualToString:now]) {
       icon = @"ic_deal_soonOver.png";
    } else if ([deal.purchase_deadline compare:now] == NSOrderedAscending){
      icon = @"ic_deal_over.png";
    }
    if (icon) {
        _bage.hidden = NO;
        _bage.image = [UIImage imageNamed:icon];
    } else{
        _bage.hidden = YES;
    }
}

@end
