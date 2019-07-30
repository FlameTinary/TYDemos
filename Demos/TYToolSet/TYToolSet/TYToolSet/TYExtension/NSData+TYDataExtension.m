//
//  NSData+TYDataExtension.m
//  TYToolSet
//
//  Created by user001 on 2018/3/28.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import "NSData+TYDataExtension.h"

@implementation NSData (TYDataExtension)
//对象转NSData:对象必须实现NSCoding
+(NSData *)objectToData:(NSObject *)object{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:object forKey:@"key"];//key是自定义的
    [archiver finishEncoding];
    return data;
}
//NSData转对象:对象必须实现NSCoding
+(NSObject *)dataToObject:(NSData *)data{
    NSKeyedUnarchiver *unArchiver=[[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSObject *object = [unArchiver decodeObjectForKey:@"key"];//key是自定义的与上面设置的应相同
    [unArchiver finishDecoding];
    return object;
}
@end
