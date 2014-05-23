//
//  DPCover.m
//  一团
//
//  Created by DP on 14-5-22.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPCover.h"

#define kAlpha 0.6

@implementation DPCover

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //背景色
        self.backgroundColor = [UIColor blackColor];
        
        //自动伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        //透明度
        self.alpha = kAlpha;
    }
    return self;
}

+(id)coverWithTarget:(id)target action:(SEL)action
{
    DPCover *cover = [self cover];
    
    [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:action]];
    
    return cover;
}

+(id)cover
{
    return [[self alloc] init];
}

-(void)reset
{
    self.alpha = kAlpha;
}

@end
