//
//  DPSubtitlesView.h
//  一团
//
//  Created by DP on 14-5-15.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPSubtitlesView;

@protocol DPSubtitlesViewDelegate <NSObject>
@optional
-(void)subtitlesView:(DPSubtitlesView *)subtitlesView titleClick:(NSString *)title;
-(NSString *)subtitlesViewGetCurrentTitle:(DPSubtitlesView *)subtitlesView;
@end

@interface DPSubtitlesView : UIImageView

@property (nonatomic, strong) NSArray *titles; // 所有的子标题文字

@property (nonatomic,weak) id<DPSubtitlesViewDelegate> delegate;

//@property (nonatomic,copy) void (^setTitleBlock)(NSString *title);
//
//@property (nonatomic,copy) NSString *(^getTitleBlock)();

// 通过动画显示出来
- (void)show;
// 通过动画隐藏
- (void)hide;
@end
