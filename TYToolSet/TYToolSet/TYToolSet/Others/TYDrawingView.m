//
//  TYDrawingView.m
//  TYToolSet
//
//  Created by user001 on 2018/3/28.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import "TYDrawingView.h"

@implementation TYDrawingView

//绘制文字

- (void)drawRect:(CGRect)rect

{
    
    // 2.设置文字的富文本属性
    
    NSMutableDictionary*attributesDict = [NSMutableDictionary dictionary];
    
    attributesDict[NSFontAttributeName] = [UIFont systemFontOfSize:28];
    
    attributesDict[NSForegroundColorAttributeName] = [UIColor greenColor];
    
    //attributesDict[NSStrokeWidthAttributeName] =@"5";
    
    //设置位置
    CGRect titleRect = [_title boundingRectWithSize:CGSizeMake(rect.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:28]} context:nil];
    
    // 3.渲染文字内容
    
    CGFloat titleX = 0;
    CGFloat titleY = (rect.size.height - titleRect.size.height)/2;
    
    
    [_title drawAtPoint:CGPointMake(titleX,titleY) withAttributes:attributesDict];
    
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self setNeedsDisplay];
}

@end
