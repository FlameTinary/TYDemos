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
    NSMutableArray * pointArrM = [NSMutableArray array];
    for (TYPoint * point in self.points) {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [dic setObject:@(point.x) forKey:@"x"];
        [dic setObject:@(point.y) forKey:@"y"];
        [dic setObject:@(point.pointType) forKey:@"type"];
        [pointArrM addObject:dic.copy];
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:pointArrM.copy options:NSJSONWritingPrettyPrinted error:nil];
    NSString * jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableString * jsonStrM = [NSMutableString stringWithString:jsonStr];
    NSRange range1 = {0, jsonStr.length};
    [jsonStrM replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range1];
    NSRange range2 = {0, jsonStrM.length};
    [jsonStrM replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return jsonStrM.copy;
}

@end
