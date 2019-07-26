//
//  TYLine.m
//  TYDrawDemo
//
//  Created by 田宇 on 2019/7/25.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYLine.h"
#import <YYModel.h>

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
    [_pointArr insertObject:point atIndex:_pointArr.count];
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

- (NSString *)description
{
    return [self yy_modelToJSONString];
}


#pragma mark - yymodel
// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"points" : [TYPoint class],
             @"pointArr" : TYPoint.class
             };
}

@end
