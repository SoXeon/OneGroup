//
//  DPOrderMenuItem.m
//  一团
//
//  Created by DP on 14-5-15.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPOrderMenuItem.h"
#import "DPOrder.h"

@implementation DPOrderMenuItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setOrder:(DPOrder *)order
{
    _order = order;
    [self setTitle:order.name forState:UIControlStateNormal];
}

@end
