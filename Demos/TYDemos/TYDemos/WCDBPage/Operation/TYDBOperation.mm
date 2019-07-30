//
//  TYDBOperation.m
//  TYDemos
//
//  Created by 田宇 on 2019/6/18.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYDBOperation.h"
#import <WCDB/WCDB.h>


#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]


@interface TYDBOperation()

@property (nonatomic, strong) WCTDatabase *database;

@end

@implementation TYDBOperation

- initWithDataName:(NSString *)dataName {
    self = [super init];
    if (self) {
        NSString * dbPath = [PATH_OF_DOCUMENT stringByAppendingPathComponent:dataName];
        NSLog(@"database path: %@", dbPath);
        self.database = [[WCTDatabase alloc] initWithPath:dbPath];
    }
    return self;
}

#pragma mark - others
- (BOOL)isTableExists:(NSString *)tableName {
    return [self.database isTableExists:tableName];
}


#pragma mark - 创建数据库和表
// 创建数据库和表
- (BOOL)creatTableAndIndexesOfName:(NSString *)tableName withClass:(Class)cls {
    if (![cls conformsToProtocol:@protocol(WCTTableCoding)]) {
        NSLog(@"Error: Class is not compliance with 'WCTTableCoding' protocol");
        return NO;
    }
    if (tableName == nil || tableName.length == 0 || [tableName rangeOfString:@" "].location != NSNotFound) {
        NSLog(@"Error: table name: %@ format error.", tableName);
        return NO;
    }
    return [self.database createTableAndIndexesOfName:tableName withClass:cls];
}


#pragma mark - 查询
// 查询数据
- (id)getOneObjectOfClass:(Class)cls fromTable:(NSString *)tableName withKeyName:(NSString *)keyName andKeyValue:(id)keyValue {
    if (!tableName.length || !keyName.length || !keyValue) {
        NSLog(@"Error: tableName or primaryKeyName or primaryKey is null");
        return nil;
    }
    NSAssert([keyValue isKindOfClass:[NSString class]] || [keyValue isKindOfClass:[NSNumber class]] , @"Data error");
    WCDB::Expr contindation(WCDB::Column(keyName.UTF8String));
    if ([keyValue isKindOfClass:[NSString class]]) {
        NSString *str = keyValue;
        contindation  = contindation == str.UTF8String;
    }else if ([keyValue isKindOfClass:[NSNumber class]]) {
        contindation  = contindation == [keyValue longLongValue];
    }
    
    if (![self.database isOpened]) {
        NSLog(@"database is not opened");
    }
    return [self.database getOneObjectOfClass:cls fromTable:tableName where:contindation];
}

// 查询全部数据
- (NSArray *)getAllObjectsOfClass:(Class)cls fromTable:(NSString *)tableName {
    if (!tableName.length) {
        NSLog(@"Error: tableName is null");
        return nil;
    }
    return [self.database getAllObjectsOfClass:cls fromTable:tableName];
}


#pragma mark - 插入
//插入单个数据
- (BOOL)insertObject:(NSObject<WCTTableCoding> *)object into:(NSString *)tableName {
    if (![object conformsToProtocol:@protocol(WCTTableCoding)]) {
        NSLog(@"Error: Class is not compliance with 'WCTTableCoding' protocol");
        return NO;
    }
    
    WCTObject *obj = (WCTObject *)object;
    
    if (![self.database isTableExists:tableName]) {
        [self.database createTableAndIndexesOfName:tableName withClass:[obj class]];
    }
    
    NSLog(@"tian - %@", self.database);
    return  [self.database insertObject:obj into:tableName];
}

// 插入多个数据
- (BOOL)insertObjects:(NSArray *)objects into:(NSString *)tableName {
    
    if (!objects || objects.count == 0) {
        NSLog(@"Error: objects is empty");
        return NO;
    }
    NSObject *obj = [objects firstObject];
    if (![obj conformsToProtocol:@protocol(WCTTableCoding)]) {
        NSLog(@"Error: Class is not compliance with 'WCTTableCoding' protocol");
        return NO;
    }
    
    if (![self.database isTableExists:tableName]) {
        [self.database createTableAndIndexesOfName:tableName withClass:[obj class]];
    }
    return [self.database insertObjects:objects into:tableName];
}

// 插入或替换单个数据
- (BOOL)insertOrReplaceObject:(NSObject<WCTTableCoding> *)object into:(NSString *)tableName {
    
    if (![object conformsToProtocol:@protocol(WCTTableCoding)]) {
        NSLog(@"Error: Class is not compliance with 'WCTTableCoding' protocol");
        return NO;
    }
    WCTObject *obj = (WCTObject *)object;
    return [self.database insertOrReplaceObject:obj into:tableName];
}

// 插入或替换多个数据
- (BOOL)insertOrReplaceObjects:(NSArray *)objects into:(NSString *)tableName {
    if (!objects || objects.count == 0) {
        NSLog(@"Error: objects is empty");
        return NO;
    }
    NSObject *obj = [objects firstObject];
    if (![obj conformsToProtocol:@protocol(WCTTableCoding)]) {
        NSLog(@"Error: Class in objects is not compliance with 'WCTTableCoding' protocol");
        return NO;
    }
    return [self.database insertOrReplaceObjects:objects into:tableName];
}


#pragma mark - 修改
// 修改数据
- (BOOL)updateObjectInTable:(NSString *)tableName withObject:(NSObject<WCTTableCoding> *)object byKeyName:(NSString *)keyName andKeyValue:(id)keyValue {
    if (!tableName.length || !keyName.length || !keyValue) {
        NSLog(@"Error: tableName or primaryKeyName or primaryKey is null");
        return NO;
    }
    if (![object conformsToProtocol:@protocol(WCTTableCoding)]) {
        NSLog(@"Error: Class is not comliance with 'WCTTableCoding' protocol");
        return NO;
    }
    NSAssert([keyValue isKindOfClass:[NSString class]] || [keyValue isKindOfClass:[NSNumber class]] , @"Data error");
    
    WCTObject *obj = (WCTObject *)object;
    WCDB::Expr contindation(WCDB::Column(keyName.UTF8String));
    if ([keyValue isKindOfClass:[NSString class]]) {
        NSString *str = keyValue;
        contindation  = contindation == str.UTF8String;
    }else if ([keyValue isKindOfClass:[NSNumber class]]) {
        contindation  = contindation == [keyValue longLongValue];
    }
    return [self.database updateRowsInTable:tableName onProperties:[obj.class AllProperties] withObject:obj where:contindation];
}


#pragma mark - 删除
// 删除指定数据
- (BOOL)deleteObjectFromTable:(NSString *)tableName withKeyName:(NSString *)keyName andKeyValue:(id)keyValue; {
    if (!tableName.length || !keyName.length || !keyValue) {
        NSLog(@"Error: tableName or primaryKeyName or primaryKey is null");
        return NO;
    }
    
    NSAssert([keyValue isKindOfClass:[NSString class]] || [keyValue isKindOfClass:[NSNumber class]] , @"Data error");
    WCDB::Expr contindation(WCDB::Column(keyName.UTF8String));
    if ([keyValue isKindOfClass:[NSString class]]) {
        NSString *str = keyValue;
        contindation  = contindation == str.UTF8String;
    }else if ([keyValue isKindOfClass:[NSNumber class]]) {
        contindation  = contindation == [keyValue longLongValue];
    }
    return [self.database deleteObjectsFromTable:tableName where:contindation];
}

// 删除表中所有数据
- (BOOL)deleteAllObjectsFromTable:(NSString *)tableName {
    return [self.database deleteAllObjectsFromTable:tableName];
}

- (BOOL)dropTableOfName:(NSString *)tableName {
    BOOL result =  [self.database dropTableOfName:tableName];
    if (!result) {
        NSLog(@"Error: %@ drop failed", tableName);
    }
    return result;
}

- (void)close {
    [self.database close];
}

- (void)close:(TYDBCloseBlock)block {
    if (block) {
        [self.database close:block];
    } else {
        [self.database close];
    }
}


#pragma mark - transation
- (void)runTransactionBlock:(TransactionBlock)block {
    //    NSString *dbPath = [self getDBPathFromService:service];
    
    //NSString *tableName = [self getTableNameFromService:service];
    
    //    WCTDatabase *database = [self.dbCache objectForKey:dbPath];
    
    //    if (!database || ![database isOpened]) {
    //        database = [[WCTDatabase alloc] initWithPath:dbPath];
    //    }
    
    [self.database beginTransaction];
    
    //TODO
    if (block) {
        block();
    }
    
    [self.database commitTransaction];
    //    if (ret) {
    //        ret = [database commitTransaction];
    //    } else {
    //        ret = [database rollbackTransaction];
    //    }
}

@end
