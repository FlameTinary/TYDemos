//
//  TYDBOperation.h
//  TYDemos
//
//  Created by 田宇 on 2019/6/18.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class WCTDatabase;
@protocol WCTTableCoding;

typedef void(^TYDBCloseBlock)();
typedef void(^TransactionBlock)();


@interface TYDBOperation : NSObject

@property (nonatomic, strong, readonly) WCTDatabase *database;

- initWithDataName:(NSString *)dataName;

#pragma mark - others
// 表是否存在
- (BOOL)isTableExists:(NSString *)tableName;


#pragma mark - create
// 创建数据库和表
- (BOOL)creatTableAndIndexesOfName:(NSString *)tableName withClass:(Class)cls;


#pragma mark - search
// 查询单个数据
- (id)getOneObjectOfClass:(Class)cls fromTable:(NSString *)tableName withKeyName:(NSString *)keyName andKeyValue:(id)keyValue;
// 查询全部数据
- (NSArray *)getAllObjectsOfClass:(Class)cls fromTable:(NSString *)tableName;


#pragma mark - insert
// 插入单个数据
- (BOOL)insertObject:(NSObject<WCTTableCoding> *)object into:(NSString *)tableName;
// 插入多个数据
- (BOOL)insertObjects:(NSArray *)objects into:(NSString *)tableName;
// 插入或替换单个数据
- (BOOL)insertOrReplaceObject:(NSObject<WCTTableCoding> *)object into:(NSString *)tableName;
// 插入或替换多个数据
- (BOOL)insertOrReplaceObjects:(NSArray *)objects into:(NSString *)tableName;


#pragma mark - update with object
// 修改数据
- (BOOL)updateObjectInTable:(NSString *)tableName withObject:(NSObject<WCTTableCoding> *)object byKeyName:(NSString *)keyName andKeyValue:(id)keyValue;


#pragma mark - delete
// 删除指定数据
- (BOOL)deleteObjectFromTable:(NSString *)tableName withKeyName:(NSString *)keyName andKeyValue:(id)keyValue;
// 删除表中所有数据
- (BOOL)deleteAllObjectsFromTable:(NSString *)tableName;
// 删除数据库
- (BOOL)dropTableOfName:(NSString *)tableName;


#pragma mark - close database
- (void)close;
- (void)close:(TYDBCloseBlock)block;

#pragma mark - transation
- (void)runTransactionBlock:(TransactionBlock)block;

@end

NS_ASSUME_NONNULL_END
