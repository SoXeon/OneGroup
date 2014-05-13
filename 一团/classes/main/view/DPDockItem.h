//
//  DPDockItem.h
//  一团
//
//  Created by 戴鹏 on 14-5-12.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DPDockItem : UIButton
{
    UIImageView *_divider;
}
- (void)setIcon:(NSString *)icon selectedIcon:(NSString *)selectedIcon;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *selectedIcon;

@end
