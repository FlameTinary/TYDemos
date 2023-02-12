//
//  TYLineLayer.m
//  TYDrawDemo
//
//  Created by Sheldon on 2019/7/25.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYLineLayer.h"

@implementation TYLineLayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor].CGColor;
        self.bezierPath = [[TYBezierPath alloc] init];
        self.bezierPath.lineJoinStyle = kCGLineJoinRound;
        self.bezierPath.lineCapStyle = kCGLineCapRound;
//        self.bezierPath.lineWidth = 10;
        
    }
    return self;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    self.bezierPath.lineWidth = lineWidth;
}

@end
