//
//  TYQuartzView.m
//  TYDrawDemo
//
//  Created by Sheldon on 2019/7/24.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYQuartzView.h"

#define kQuartzEraseLineWidth 10
#define kQuartzLineWidth 10

@interface TYQuartzView()
@property(nonatomic, assign) CGPoint previousPoint1;
@property(nonatomic, assign) CGPoint previousPoint2;
@property(nonatomic, assign) CGPoint currentPoint;
@property(nonatomic, strong) NSUndoManager * undoManager;
@property(nonatomic, strong) NSMutableArray * pointsArrM;
@property(nonatomic, strong) UIImage * curImage;
@property(nonatomic, assign) CGContextRef context;

@end

@implementation TYQuartzView
@synthesize undoManager;

/**
 NSUndoManager简单说明:
 每个人都会犯错误。多亏了 Foundation 库提供了比拼写错误更强大的功能来解救我们。Cocoa 有一套简单强壮的 NSUndoManager API 管理撤销和重做。
 
 默认地，每个应用的 window 都有一个 undo manager，每一个响应链条中的对象都可以管理一个自定义的 undo manager 来管理各自页面上本地操作的撤销和重做操作。UITextField 和 UITextView 用这个功能自动提供了文本编辑的撤销重做支持。然而，标明哪些动作可以被撤销是留给应用开发工程师的工作。
 
 创建一个可以撤销的动作需要三步：做出改变，注册一个可以逆向的 "撤销操作"，响应撤销改变的动作。
 详细参照 ：http://nshipster.cn/nsundomanager/

 Quartz2D简单说明:
 在画线的时候，方法的内部默认创建一个path。它把路径都放到了path里面去。
 >1.创建路径  CGMutablePathRef 调用该方法相当于创建了一个路径，这个路径用来保存绘图信息。
 >2.把绘图信息添加到路径里边。 以前的方法是点的位置添加到ctx（图形上下文信息）中，ctx 默认会在内  部创建一个path用来保存绘图信息。在图形上下文中有一块存储空间专门用来存储绘图信息，其实这块空间就是CGMutablePathRef。
 >3.把路径添加到上下文中。
 
 参看:
 https://www.jianshu.com/p/8c145884cf2c
*/

- (void)drawRect:(CGRect)rect {
    // 获取上下文
    [self.curImage drawAtPoint:CGPointMake(0, 0)];
    CGPoint mid1 = midPoint1(self.previousPoint1, self.previousPoint2);
    CGPoint mid2 = midPoint1(self.currentPoint, self.previousPoint1);
    
    self.context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:self.context];
    CGContextMoveToPoint(self.context, mid1.x, mid1.y);
    
    // 添加画点
    CGContextAddQuadCurveToPoint(self.context, self.previousPoint1.x, self.previousPoint1.y, mid2.x, mid2.y);
    // 设置圆角
    CGContextSetLineCap(self.context, kCGLineCapRound);
    // 设置线宽
    CGContextSetLineWidth(self.context, self.isErase? kQuartzEraseLineWidth:kQuartzLineWidth);
    // 设置画笔颜色
    CGContextSetStrokeColorWithColor(self.context, self.isErase?[UIColor clearColor].CGColor:self.lineColor.CGColor);
    
    CGContextSetLineJoin(self.context, kCGLineJoinRound);
    
    // 根据是否橡皮擦设置画笔模式
    CGContextSetBlendMode(self.context, self.isErase ? kCGBlendModeDestinationIn : kCGBlendModeNormal);
    
    CGContextStrokePath(self.context);
    
    [super drawRect:rect];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pointsArrM = [NSMutableArray array];
        [self setup];
    }
    return self;
}

- (void)setup {
    self.multipleTouchEnabled = YES;
    self.lineWidth = 5;
    self.lineColor = [UIColor redColor];
    
    // 初始化NSUndoManager
    NSUndoManager * tempUndoManager = [[NSUndoManager alloc] init];
    [tempUndoManager setLevelsOfUndo:10];
    [self setUndoManager:tempUndoManager];
}

- (void)clear {
    self.previousPoint1 = CGPointMake(0, 0);
    self.previousPoint2 = CGPointMake(0, 0);
    self.currentPoint = CGPointMake(0, 0);
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
    self.previousPoint1 = currentPoint;
    self.previousPoint2 = currentPoint;
    self.currentPoint = currentPoint;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, self.previousPoint1.x, self.previousPoint1.y);
    
    [self.pointsArrM removeAllObjects];
    // 添加点集合
    NSDictionary * dict = @{
                            @"x": @(currentPoint.x),
                            @"y": @(currentPoint.y)
                            };
    [self.pointsArrM addObject:dict];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    self.previousPoint2 = self.previousPoint1;
    self.previousPoint1 = [touch previousLocationInView:self];
    self.currentPoint = currentPoint;
    
    CGPoint mid1 = midPoint1(self.previousPoint1, self.previousPoint2);
    CGPoint mid2 = midPoint1(self.currentPoint, self.previousPoint1);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, mid1.x, mid1.y);
    CGPathAddQuadCurveToPoint(path, NULL, self.previousPoint1.x, self.previousPoint1.y, mid2.x, mid2.y);
    
    CGRect bounds = CGPathGetBoundingBox(path);
    CGPathRelease(path);
    CGRect drawBox = bounds;
    
    drawBox.origin.x -= self.lineWidth * 2;
    drawBox.origin.y -= self.lineWidth * 2;
    drawBox.size.width += self.lineWidth * 4;
    drawBox.size.height += self.lineWidth * 4;
    
    UIGraphicsBeginImageContext(drawBox.size);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    self.curImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [self setNeedsDisplayInRect:drawBox];
    
    NSDictionary * dict = @{
                            @"x": @(currentPoint.x),
                            @"y": @(currentPoint.y)
                            };
    [self.pointsArrM addObject:dict];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    self.previousPoint2 = self.previousPoint1;
    self.previousPoint1 = [touch previousLocationInView:self];
    self.currentPoint = currentPoint;
    
    CGPoint mid1 = midPoint1(self.previousPoint1, self.previousPoint2);
    CGPoint mid2 = midPoint1(self.currentPoint, self.previousPoint1);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, mid1.x, mid1.y);
    CGPathAddQuadCurveToPoint(path, NULL, self.previousPoint1.x, self.previousPoint1.y, mid2.x, mid2.y);
    
    // 绘画
    CGRect bounds = CGPathGetBoundingBox(path);
    CGPathRelease(path);
    CGRect drawBox = bounds;
    
    drawBox.origin.x -= self.lineWidth * 2;
    drawBox.origin.y -= self.lineWidth * 2;
    drawBox.size.width += self.lineWidth * 4;
    drawBox.size.height += self.lineWidth * 4;
    
    UIGraphicsBeginImageContext(drawBox.size);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    self.curImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [self setNeedsDisplayInRect:drawBox];
    
    NSDictionary * dict = @{
                            @"x": @(currentPoint.x),
                            @"y": @(currentPoint.y)
                            };
    [self.pointsArrM addObject:dict];
    
}

#pragma mark - private
// 计算中间点
CGPoint midPoint1(CGPoint p1, CGPoint p2) {
    return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
}

@end
