//
//  DPTabItem.m
//  一团
//
//  Created by 戴鹏 on 14-5-12.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPTabItem.h"

@implementation DPTabItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置选中时候的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"bg_tabbar_item.png"] forState:UIControlStateDisabled];
    }
    return self;
}

- (void)setEnabled:(BOOL)enabled
{
    _divider.hidden = !enabled;
    
    [super setEnabled:enabled];
}

@end
