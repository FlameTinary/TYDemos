//
//  TYBezierPathDrawView.m
//  TYDrawDemo
//
//  Created by 田宇 on 2019/7/24.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYBezierPathDrawView.h"
#import "TYBezierPath.h"

#define kBezierEraseLineWidth 10
#define kBezierLineWidth 10

@interface TYBezierPathDrawView()
@property(nonatomic, strong) TYBezierPath *bezierPath;
@property(nonatomic, strong) NSMutableArray<TYBezierPath *> *bezierPathArrM;
@end

@implementation TYBezierPathDrawView

- (void)drawRect:(CGRect)rect {
    // 获取上下文
    if (self.bezierPathArrM.count) {
        for (TYBezierPath * path in self.bezierPathArrM) {
            if (path.isErase) { // 橡皮擦
                // 橡皮擦设置无色
                [[UIColor clearColor] setStroke];
            } else {
                [path.lineColor setStroke];
            }
            path.lineJoinStyle = kCGLineJoinRound;
            path.lineCapStyle = kCGLineCapRound;
            if (path.isErase) {
                path.lineWidth = kBezierEraseLineWidth;
                [path strokeWithBlendMode:kCGBlendModeCopy alpha:1.0];
            } else {
                path.lineWidth = kBezierLineWidth;
                [path strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
            }
            [path stroke];
        }
    }
    [super drawRect:rect];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lineColor = [UIColor redColor];
        self.isErase = NO;
        self.bezierPathArrM = [NSMutableArray array];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    NSLog(@"touchesBegan.currentPoint(%lf, %lf)", currentPoint.x, currentPoint.y);
    
    self.bezierPath = [[TYBezierPath alloc] init];
    self.bezierPath.lineColor = self.lineColor;
    self.bezierPath.isErase = self.isErase;
    [self.bezierPath moveToPoint:currentPoint];
    [self.bezierPathArrM addObject:self.bezierPath];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesMoved");
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint previousPoint = [touch previousLocationInView:self];
    NSLog(@"touchesMoved.currentPoint(%lf, %lf)", currentPoint.x, currentPoint.y);
    NSLog(@"touchesMoved.previousPoint(%lf, %lf)", previousPoint.x, previousPoint.y);
    CGPoint midP = midPoint(previousPoint,currentPoint);
    
    // touchesMoved 方法中添加每一个点到self.bezierPath中
    // 使用二次贝塞尔曲线比使addLine画线更圆润拐点没有尖角
    [self.bezierPath addQuadCurveToPoint:currentPoint controlPoint:midP];
    
    // 主动调用绘画方法 <setNeedDisplay会自动调用drawrect方法 不要直接调用drawrect>
    [self setNeedsDisplay];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesEnded");
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint previousPoint = [touch previousLocationInView:self];
    NSLog(@"touchesEnded.currentPoint(%lf, %lf)", currentPoint.x, currentPoint.y);
    NSLog(@"touchesEnded.previousPoint(%lf, %lf)", previousPoint.x, previousPoint.y);
    CGPoint midP = midPoint(currentPoint, previousPoint);
    
    [self.bezierPath addQuadCurveToPoint:currentPoint controlPoint:midP];
    [self setNeedsDisplay];
}


#pragma mark - private
CGPoint midPoint(CGPoint p1, CGPoint p2) {
    return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
}


- (void)clear{
    [self.bezierPathArrM removeAllObjects];
    [self setNeedsDisplay];
}
@end
