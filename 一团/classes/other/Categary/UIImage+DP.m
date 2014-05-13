//
//  UIImage+DP.m
//  NiuNiuWeiBo
//
//  Created by 戴鹏 on 14-4-15.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "UIImage+DP.h"

@implementation UIImage (DP)

+ (UIImage *)resizedImage:(NSString *)imgName
{
    return [self resizedImage:imgName xPos:0.5 yPos:0.5];
}

+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos
{
    UIImage *image = [UIImage imageNamed:imgName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * xPos topCapHeight:image.size.height * yPos];
}




@end
