//
//  TYDBService.m
//  TYDemos
//
//  Created by 田宇 on 2019/6/19.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYDBService.h"

@interface TYDBService()

@property(nonatomic, copy, readwrite) NSString * dataName;

@end

@implementation TYDBService
- (instancetype)initWithTableName:(NSString *)tableName class:(Class)cls
{
    self = [super init];
    if (self) {
        TYDBOperation *operation = [[TYDBOperation alloc] initWithDataName:self.dataName];
        [operation creatTableAndIndexesOfName:tableName withClass:cls];
        _operation = operation;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

+ (NSString *)getClassName {
    return [NSString stringWithFormat:@"112233 - %@", NSStringFromClass([self class])];
}

- (NSString *)dataName {
    return @"sampleDB.db";
}

@end
