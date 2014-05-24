//
//  DPRoundRectView.m
//  一团
//
//  Created by DP on 14-5-23.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPRoundRectView.h"
#import "UIImage+DP.h"


@implementation DPRoundRectView

-(void)drawRect:(CGRect)rect
{
    [[UIImage resizedImage:@"bg_order_cell.png"] drawInRect:rect];
}

@end
