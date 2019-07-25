//
//  TYLineLayer.m
//  TYDrawDemo
//
//  Created by 田宇 on 2019/7/25.
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
        [[UIColor redColor] setStroke];
        self.bezierPath.lineWidth = 10;
        
    }
    return self;
}

@end
