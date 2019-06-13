//
//  TYHeartView.m
//  TYToolSet
//
//  Created by user001 on 2018/9/30.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import "TYHeartView.h"

@implementation TYHeartView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    // 间距
    CGFloat padding = 4.0;
    // 半径(小圆半径)
    CGFloat curveRadius = (rect.size.width - 2 * padding)/4.0;
    // 贝塞尔曲线
    UIBezierPath *heartPath = [UIBezierPath bezierPath];
    // 起点(圆的第一个点)
    CGPoint tipLocation = CGPointMake(rect.size.width/2, rect.size.height-padding);
    // 从起点开始画
    [heartPath moveToPoint:tipLocation];
    // (左圆的第二个点)
    CGPoint topLeftCurveStart = CGPointMake(padding, rect.size.height/2.4);
    // 添加二次曲线
    [heartPath addQuadCurveToPoint:topLeftCurveStart controlPoint:CGPointMake(topLeftCurveStart.x, topLeftCurveStart.y + curveRadius)];
    // 画圆
    [heartPath addArcWithCenter:CGPointMake(topLeftCurveStart.x+curveRadius, topLeftCurveStart.y) radius:curveRadius startAngle:M_PI endAngle:0 clockwise:YES];
    // (左圆的第二个点)
    CGPoint topRightCurveStart = CGPointMake(topLeftCurveStart.x + 2*curveRadius, topLeftCurveStart.y);
    // 画圆
    [heartPath addArcWithCenter:CGPointMake(topRightCurveStart.x+curveRadius, topRightCurveStart.y) radius:curveRadius startAngle:M_PI endAngle:0 clockwise:YES];
    // 右上角控制点
    CGPoint topRightCurveEnd = CGPointMake(topLeftCurveStart.x + 4*curveRadius, topRightCurveStart.y);
    // 添加二次曲线
    [heartPath addQuadCurveToPoint:tipLocation controlPoint:CGPointMake(topRightCurveEnd.x, topRightCurveEnd.y+curveRadius)];
    // 设置填充色
    [[UIColor redColor] setFill];
    // 填充
    [heartPath fill];
    // 设置边线
    heartPath.lineWidth = 2;
    heartPath.lineCapStyle  = kCGLineCapRound;
    heartPath.lineJoinStyle = kCGLineJoinRound;
    // 设置描边色
    [[UIColor yellowColor] setStroke];
    [heartPath stroke];
    
}

@end
