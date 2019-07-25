//
//  TYLine.m
//  TYDrawDemo
//
//  Created by 田宇 on 2019/7/25.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYLine.h"

@interface TYLine()
@property(nonatomic, readwrite, strong) TYPoint * firstPoint;
@property(nonatomic, readwrite, strong) TYPoint * endPoint;
@property(nonatomic, readwrite, strong) NSMutableArray<TYPoint *> * pointArr;
@end

@implementation TYLine

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pointArr = [NSMutableArray array];
    }
    return self;
}

- (void)addPoint:(TYPoint *)point {
    [_pointArr addObject:point];
}
- (void)addPointToFirst:(TYPoint *)point {
    _firstPoint = point;
    [_pointArr insertObject:point atIndex:0];
}
- (void)addPointToEnd:(TYPoint *)point {
    _endPoint = point;
    [_pointArr insertObject:point atIndex:_pointArr.count - 1];
}
- (void)addPoint:(TYPoint *)point atIndex:(int)index {
    if (_pointArr.count > index) {
        [_pointArr insertObject:point atIndex:index];
    } else {
        [_pointArr addObject:point];
    }
}


- (NSArray<TYPoint *> *)points {
    return _pointArr.copy;
}

@end
