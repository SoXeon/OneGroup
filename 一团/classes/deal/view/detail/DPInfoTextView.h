
//
//  DPInfoTextView.h
//  一团
//
//  Created by DP on 14-5-23.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPRoundRectView.h"

@interface DPInfoTextView : DPRoundRectView
@property (weak, nonatomic) IBOutlet UIButton *titleView;
@property (weak, nonatomic) IBOutlet UILabel *contentView;

@property (nonatomic,copy)NSString *icon;//图标
@property (nonatomic,copy)NSString *title;//标题
@property (nonatomic,copy)NSString *content;//内容


+(id)infoTextView;
@end
