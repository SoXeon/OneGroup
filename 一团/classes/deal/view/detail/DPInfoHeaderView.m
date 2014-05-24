//
//  DPInfoHeaderView.m
//  一团
//
//  Created by DP on 14-5-23.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPInfoHeaderView.h"
#import "NSDate+DP.h"
#import "DPDeal.h"
#import "DPImageTool.h"
#import "DPRestrictions.h"

@implementation DPInfoHeaderView

-(void)setDeal:(DPDeal *)deal
{
    _deal = deal;
    
    if (deal.restrictions) {
        //设置支持退款
        _anyTimeBack.enabled = deal.restrictions.is_refundable;
        _expireBack.enabled = _anyTimeBack.enabled;
    } else {
        //下载图片
        [DPImageTool downloadImage:deal.image_url placeholder:[UIImage imageNamed:@"placeholder_deal.png"] imageView:_image];
        
        //设置剩余时间
        NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
        fmt.dateFormat = @"yyyy-MM-dd";
        NSDate *dealline = [fmt dateFromString:deal.purchase_deadline];
        dealline = [dealline dateByAddingTimeInterval:24 * 3600];
        NSDate *now = [NSDate date];
        
        NSDateComponents *cmps = [now compare:dealline];
        
        NSString *timeStr = [NSString stringWithFormat:@"%d 天 %d 小时 ",cmps.day,cmps.hour];
        
        [_time setTitle:timeStr forState:UIControlStateNormal];
    }
    
    //购买人数
    NSString *pc = [NSString stringWithFormat:@"%d人已购买",deal.purchase_count];
    [_purchaseCount setTitle:pc forState:UIControlStateNormal];
    
    //设置描述
    _desc.text = deal.desc;
    
    NSDictionary *attribute = @{NSFontAttributeName:_desc.font};
    
    CGFloat descH = [_desc.text boundingRectWithSize:CGSizeMake(_desc.frame.size.width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size.height + 15;
    
    CGRect descF = _desc.frame;
    
    CGFloat descDeltaH = descH - descF.size.height;
    
    descF.size.height = descH;
    
    _desc.frame = descF;

    //设置整体的高度
    CGRect selfF = self.bounds;
    selfF.size.height += descDeltaH;
    self.bounds = selfF;
    
}


-(void)setFrame:(CGRect)frame
{
    frame.size.height = self.frame.size.height;
    [super setFrame:frame];
}

+(id)infoHeaderView
{
    return [[NSBundle mainBundle] loadNibNamed:@"DPInfoHeaderView" owner:nil options:nil][0];
}


@end
