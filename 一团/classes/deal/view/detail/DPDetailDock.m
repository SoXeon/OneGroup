//
//  DPDetailDock.m
//  一团
//
//  Created by DP on 14-5-22.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPDetailDock.h"

@interface DPDetailDock()
{
    UIButton *_selectedBtn;
}

@end

@implementation DPDetailDock

-(void)setFrame:(CGRect)frame
{
    frame.size = self.frame.size;
    [super setFrame:frame];
}

+(id)detailDock
{
    return [[NSBundle mainBundle]loadNibNamed:@"DPDetailDock" owner:nil options:nil][0];
}

-(void)awakeFromNib
{
    [self btnClick:_infoBtn];
}

- (IBAction)btnClick:(UIButton *)sender {
    //通知代理
    if ([_delegate respondsToSelector:@selector(detailDock:btnClickFrom:to:)]) {
        [_delegate detailDock:self btnClickFrom:_selectedBtn.tag to:sender.tag];
    }
    
    _selectedBtn.enabled = YES;
    sender.enabled = NO;
    _selectedBtn = sender;
    
    //添加被点击的按钮在最上面
    if (sender == _infoBtn) {
        [self insertSubview:_merchantBtn atIndex:0];
    } else if (sender == _merchantBtn) {
        [self insertSubview:_infoBtn atIndex:0];
    }
    [self bringSubviewToFront:sender];
}

@end


@implementation DPDetailDockItem

-(void)setHighlighted:(BOOL)highlighted
{
    
}

@end