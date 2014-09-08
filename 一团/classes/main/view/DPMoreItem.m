//
//  DPMoreItem.m
//  一团
//
//  Created by 戴鹏 on 14-5-12.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPMoreItem.h"
#import "DPMoreController.h"

@implementation DPMoreItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //自动伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        //设置图片
        [self setIcon:@"ic_more.png" selectedIcon:@"ic_more_hl.png"];
        
        //监听点击
        [self addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchDown];
        
    }
    return self;
}

- (void)moreClick
{
    //弹出更多控制器
    self.enabled = NO;
    DPMoreController *more = [[DPMoreController alloc]init];
    
    //moreItem 被当前控制器拥有
    more.moreItem = self;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:more];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
}

@end
