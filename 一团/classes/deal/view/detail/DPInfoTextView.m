//
//  DPInfoTextView.m
//  一团
//
//  Created by DP on 14-5-23.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPInfoTextView.h"

@implementation DPInfoTextView


+(id)infoTextView
{
    return [[NSBundle mainBundle]loadNibNamed:@"DPInfoTextView" owner:nil options:nil][0];
}

-(void)setContent:(NSString *)content
{
    _content = content;
    _contentView.text = content;
    NSDictionary *attribute = @{NSFontAttributeName:_contentView.font};
    CGFloat textH = [content boundingRectWithSize:CGSizeMake(_contentView.frame.size.width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size.height;
    
    CGRect contentF = _contentView.frame;
    CGFloat contentDelatH = textH - contentF.size.height;
    contentF.size.height = textH;
    _contentView.frame = contentF;
    
    //调整整体的高度
    CGRect selfF = self.frame;
    selfF.size.height += contentDelatH;
    self.frame = selfF;
    
}

-(void)setIcon:(NSString *)icon
{
    _icon = icon;
    [_titleView setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    [_titleView setTitle:title forState:UIControlStateNormal];
}


@end
