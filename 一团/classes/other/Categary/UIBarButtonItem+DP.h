//
//  UIBarButtonItem+DP.h
//  NiuNiuWeiBo
//
//  Created by 戴鹏 on 14-4-15.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (DP)

- (id)initWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target  action:(SEL)action;

+ (id)itemWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action;

@end
