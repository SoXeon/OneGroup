//
//  DPDetailDock.h
//  一团
//
//  Created by DP on 14-5-22.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DPDetailDockItem,DPDetailDock;

//协议
@protocol DPDetailDockDelegate <NSObject>

@optional
-(void)detailDock:(DPDetailDock *)detailDock btnClickFrom:(int)from to:(int)to;

@end
//DPDetailDock
@interface DPDetailDock : UIView
@property (weak, nonatomic) IBOutlet DPDetailDockItem *infoBtn;
@property (weak, nonatomic) IBOutlet DPDetailDockItem *merchantBtn;

@property (nonatomic,weak) id<DPDetailDockDelegate> delegate;

- (IBAction)btnClick:(UIButton *)sender;
+(id)detailDock;

@end

@interface DPDetailDockItem : UIButton

@end