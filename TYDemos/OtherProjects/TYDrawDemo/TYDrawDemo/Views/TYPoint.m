//
//  TYPoint.m
//  TYDrawDemo
//
//  Created by 田宇 on 2019/7/25.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYPoint.h"

@implementation TYPoint

+ (instancetype)pointWithPoint:(CGPoint)point andType:(TYPointType)type {
    TYPoint *p = [[self alloc] init];
    p.x = point.x;
    p.y = point.y;
    p.pointType = type;
    return p;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"{\"x\":%lf,\"y\":%lf,\"type\":%lu}", self.x, self.y, (unsigned long)self.pointType];
}


@end
