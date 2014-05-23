//
//  DPCover.h
//  一团
//
//  Created by DP on 14-5-22.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DPCover : UIView
+ (id)cover;
+ (id)coverWithTarget:(id)target action:(SEL)action;
-(void)reset;
@end
