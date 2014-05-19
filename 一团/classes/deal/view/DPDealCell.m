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
        // Initialization code
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
    _price.text = [NSString stringWithFormat:@"%.f",deal.current_price];
    
    //5.标签
    
}

@end
