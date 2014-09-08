//
//  DPDock.h
//  一团
//
//  Created by 戴鹏 on 14-5-11.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPDock;

@protocol DPDockDelegate <NSObject>
@optional
- (void)dock:(DPDock *)dock tabChangeFrom:(int)from to:(int)to;

@end

@interface DPDock : UIView
@property (nonatomic,weak) id<DPDockDelegate> delegate;
@end
