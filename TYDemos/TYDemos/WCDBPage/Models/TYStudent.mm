//
//  TYStudent.mm
//  TYDemos
//
//  Created by 田宇 on 2019/6/15.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYStudent+WCTTableCoding.h"
#import "TYStudent.h"
#import <WCDB/WCDB.h>

@implementation TYStudent

/********继承的类必须重新映射*********/

//WCDB_IMPLEMENTATION，用于在类文件中定义绑定到数据库表的类
WCDB_IMPLEMENTATION(TYStudent)
//WCDB_SYNTHESIZE，用于在类文件中定义绑定到数据库表的字段
WCDB_SYNTHESIZE(TYStudent, localID)
WCDB_SYNTHESIZE(TYStudent, name)
WCDB_SYNTHESIZE(TYStudent, age)
WCDB_SYNTHESIZE(TYStudent, gender)

WCDB_SYNTHESIZE_DEFAULT(TYStudent, createDate, WCTDefaultTypeCurrentDate) //设置一个默认值
//主键
WCDB_PRIMARY_AUTO_INCREMENT(TYStudent, localID)
//用于定义非空约束
WCDB_NOT_NULL(TYStudent, name)

/********继承的类必须重新映射*********/

WCDB_SYNTHESIZE(TYStudent, job)
WCDB_SYNTHESIZE(TYStudent, stature)
WCDB_SYNTHESIZE(TYStudent, timer)
WCDB_SYNTHESIZE(TYStudent, testDic)

//默认使用属性名作为数据库表的字段名。对于属性名与字段名不同的情况，可以使用WCDB_SYNTHESIZE_COLUMN(className, propertyName, columnName)进行映射。
WCDB_SYNTHESIZE_COLUMN(TYStudent, totalScore, "db_totalScore")

@end
