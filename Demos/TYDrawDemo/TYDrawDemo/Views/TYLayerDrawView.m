//
//  TYLayerDrawView.m
//  TYDrawDemo
//
//  Created by 田宇 on 2019/7/25.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYLayerDrawView.h"
#import "TYLineLayer.h"
#import "TYLine.h"
#import <YYModel.h>

@interface TYLayerDrawView()<CALayerDelegate>

@property(nonatomic, strong) TYLine * currentLine; // 当前绘制的线
@property(nonatomic, strong) TYLineLayer * currentLayer; // 当前绘制的layer
@property(nonatomic, strong) NSMutableArray<TYLineLayer *> * layerArrM; // 存储已绘制的layer
@property(nonatomic, strong) NSMutableArray<TYLine *> *lines; // 存储已绘制的线

@end

//static const CGFloat kBezierEraseLineWidth = 10;
static const CGFloat kBezierLineWidth = 10;
static NSString * kTableName = @"TYLINETABLE";

@implementation TYLayerDrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _lineColor = 0x656565;
        _lineWidth = kBezierLineWidth;
        _isErase = NO;
        _layerArrM = [NSMutableArray array];
        _lines = [NSMutableArray array];
    }
    return self;
}


#pragma mark - draw lines
- (void)drawLines:(NSArray<TYLine *> *)lines {
    [_lines addObjectsFromArray:lines];
    if (!_lines || _lines.count == 0) return;
    for (TYLine * line in _lines) {
        _currentLine = line;
        // 生成layer
        _currentLayer = [[TYLineLayer alloc] init];
        _currentLayer.lineWidth = self.lineWidth;
        _currentLayer.delegate = self;
        _currentLayer.frame = self.layer.bounds;
        [self.layer addSublayer:_currentLayer];
        [_layerArrM addObject:_currentLayer];
        
        for (int i = 0; i < line.points.count; i++) {
            // 划线
            if (i == 0) {
                TYPoint * firstPoint = line.points[i];
                [_currentLayer.bezierPath moveToPoint:CGPointMake(firstPoint.x, firstPoint.y)];
            } else {
                TYPoint * currentPoint = line.points[i];
                TYPoint * previousPoint = line.points[i - 1];
                
                CGPoint midP = midPoint2(CGPointMake(currentPoint.x, currentPoint.y), CGPointMake(previousPoint.x, previousPoint.y));
                
                [_currentLayer.bezierPath addQuadCurveToPoint:CGPointMake(currentPoint.x, currentPoint.y) controlPoint:midP];
                
            }
            [_currentLayer setNeedsDisplay];
        }
    }
    
}


#pragma mark - touch and draw methods
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
    _currentLayer = [[TYLineLayer alloc] init];
    _currentLayer.lineWidth = self.lineWidth;
    _currentLayer.delegate = self;
    _currentLayer.frame = self.layer.bounds;
    [self.layer addSublayer:_currentLayer];
    [_layerArrM addObject:_currentLayer];
    
//    _currentLayer.bezierPath.lineColor = self.lineColor;
//    _currentLayer.bezierPath.isErase = self.isErase;
    [_currentLayer.bezierPath moveToPoint:currentPoint];
    [_currentLayer setNeedsDisplay];
    
    TYPoint * tpoint = [TYPoint pointWithPoint:currentPoint andType:TYPointTypeStart];
    _currentLine = [[TYLine alloc] init];
    _currentLine.color = self.lineColor;
    _currentLine.width = self.lineWidth;
    [_currentLine addPointToFirst:tpoint];
    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint previousPoint = [touch previousLocationInView:self];
    
    CGPoint midP = midPoint2(currentPoint, previousPoint);
    
    [self.currentLayer.bezierPath addQuadCurveToPoint:currentPoint controlPoint:midP];
    [_currentLayer setNeedsDisplay];
    
    TYPoint * tpoint = [TYPoint pointWithPoint:currentPoint andType:TYPointTypeMove];
    [_currentLine addPoint:tpoint];
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint previousPoint = [touch previousLocationInView:self];
    
    CGPoint midP = midPoint2(currentPoint, previousPoint);
    
    [self.currentLayer.bezierPath addQuadCurveToPoint:currentPoint controlPoint:midP];
    
//    if (_layerArrM.count > 2) {
//        CALayer * la = [_layerArrM firstObject];
//        [la removeFromSuperlayer];
//        [_layerArrM removeObject:la];
//    }
    [_currentLayer setNeedsDisplay];
    
    TYPoint * tpoint = [TYPoint pointWithPoint:currentPoint andType:TYPointTypeEnd];
    [_currentLine addPointToEnd:tpoint];
    [_lines addObject:_currentLine];
    //NSLog(@"%@", _currentLine.description);
    NSString * linesStr = [_lines yy_modelToJSONString];
    [self writeToFile:linesStr];
}

#pragma mark - CALayerDelegate
- (void)drawLayer:(TYLineLayer *)layer inContext:(CGContextRef)ctx
{
    UIGraphicsPushContext( ctx );
    [HexColor(self.lineColor) setStroke];
    [layer.bezierPath strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
    UIGraphicsPopContext();
}



#pragma mark - private
- (void)writeToFile:(NSString *)str {
    NSString * documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * filePath = [documentDirectory stringByAppendingPathComponent:@"lines"];
    
    // 先删除原有的文件
    NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL isExists = [fileManager fileExistsAtPath:filePath];
    if (isExists) [fileManager removeItemAtPath:filePath error:nil];
    
    // 创建文件
    [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    
    // 写入文件
    [str writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

CGPoint midPoint2(CGPoint p1, CGPoint p2) {
    return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
}

UIColor * HexColor(UInt32 s) {
    return [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0];
}


@end
