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

#define kBezierEraseLineWidth 10
#define kBezierLineWidth 10
#define HexColor(s)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]

@interface TYLayerDrawView()<CALayerDelegate>

@property(nonatomic, strong) TYLine * currentLine;
@property(nonatomic, strong) TYLineLayer * currentLayer;
@property(nonatomic, strong) NSMutableArray<TYLineLayer *> * layerArrM;
@property(nonatomic, strong) NSMutableArray<TYLine *> *lines;

@end

@implementation TYLayerDrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lineColor = 0x656565;
        self.lineWidth = 10;
        self.isErase = NO;
        _layerArrM = [NSMutableArray array];
        _lines = [NSMutableArray array];
    }
    return self;
}

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
CGPoint midPoint2(CGPoint p1, CGPoint p2) {
    return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
}
@end
