//
//  TYPoint.m
//  TYDrawDemo
//
//  Created by 田宇 on 2019/7/25.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYPoint.h"
#import <YYModel.h>

@implementation TYPoint

+ (instancetype)pointWithPoint:(CGPoint)point andType:(TYPointType)type {
    TYPoint *p = [[self alloc] init];
    p.x = point.x;
    p.y = point.y;
    p.pointType = type;
    return p;
}

-(NSString *)description {
    return [self yy_modelToJSONString];
}


@end
