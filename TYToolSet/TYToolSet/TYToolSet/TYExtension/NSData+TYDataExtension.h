//
//  NSData+TYDataExtension.h
//  TYToolSet
//
//  Created by user001 on 2018/3/28.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (TYDataExtension)
//对象转NSData:对象必须实现NSCoding
+(NSData *)objectToData:(NSObject *)object;
//NSData转对象:对象必须实现NSCoding
+(NSObject *)dataToObject:(NSData *)data;
@end
