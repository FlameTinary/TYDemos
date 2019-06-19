//
//  TYDBService.h
//  TYDemos
//
//  Created by 田宇 on 2019/6/19.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYDBOperation.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYDBService : NSObject

@property(nonatomic, copy, readonly) NSString * dataName;
@property(nonatomic, copy, readonly) NSString * tableName;
@property(nonatomic, strong, readonly) TYDBOperation * operation;

- (instancetype)initWithTableName:(NSString *)tableName class:(Class)cls;

+ (NSString *)getClassName;

@end

NS_ASSUME_NONNULL_END
