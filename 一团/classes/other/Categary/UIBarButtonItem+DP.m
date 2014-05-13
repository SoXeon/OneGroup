//
//  UIBarButtonItem+DP.m
//  NiuNiuWeiBo
//
//  Created by 戴鹏 on 14-4-15.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "UIBarButtonItem+DP.h"

@implementation UIBarButtonItem (DP)

- (id)initWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target  action:(SEL)action
{
    UIButton *btn = [ UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *Image = [UIImage imageNamed:icon];
    [btn setBackgroundImage:Image forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
    btn.bounds = (CGRect){CGPointZero, Image.size};
    
    return [self initWithCustomView:btn];
    
}


+ (id)itemWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action
{
    return [[self alloc] initWithIcon:icon highlightedIcon:highlighted target:target action:action];
}

@end
