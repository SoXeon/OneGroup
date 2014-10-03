//
//  DPLineLabel.m
//  一团
//
//  Created by DP on 14-5-22.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPLineLabel.h"

@implementation DPLineLabel

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //获取文字
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //设置颜色
    [self.textColor setStroke];
    
    //画笔
    CGFloat y = rect.size.height * 0.5;
    CGContextMoveToPoint(ctx, 0, y);
    CGFloat endX = [self.text sizeWithFont:self.font].width;
    CGContextAddLineToPoint(ctx, endX, y);
    
    //渲染
    CGContextStrokePath(ctx);
}

@end
