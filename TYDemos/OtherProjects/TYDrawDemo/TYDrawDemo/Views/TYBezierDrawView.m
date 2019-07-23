//
//  TYBezierDrawView.m
//  TYDrawDemo
//
//  Created by 田宇 on 2019/7/23.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYBezierDrawView.h"

@implementation TYBezierDrawView

- (void)drawRect:(CGRect)rect {
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    // 设置绘制属性
    path.lineWidth = 1;
    UIColor *color = [UIColor redColor];
    [color set];
    
    // 安装路径绘制图形
    [path stroke];
}

@end
