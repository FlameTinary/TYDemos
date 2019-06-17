//
//  TYPerson.mm
//  TYDemos
//
//  Created by 田宇 on 2019/6/15.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYPerson+WCTTableCoding.h"
#import "TYPerson.h"
#import <WCDB/WCDB.h>

@implementation TYPerson

//WCDB_IMPLEMENTATION，用于在类文件中定义绑定到数据库表的类
WCDB_IMPLEMENTATION(TYPerson)
//WCDB_SYNTHESIZE，用于在类文件中定义绑定到数据库表的字段
WCDB_SYNTHESIZE(TYPerson, localID)
WCDB_SYNTHESIZE(TYPerson, name)
WCDB_SYNTHESIZE(TYPerson, age)
WCDB_SYNTHESIZE(TYPerson, gender)

WCDB_SYNTHESIZE_DEFAULT(TYPerson, createDate, WCTDefaultTypeCurrentDate) //设置一个默认值

//主键
WCDB_PRIMARY_AUTO_INCREMENT(TYPerson, localID)

//用于定义非空约束
WCDB_NOT_NULL(TYPerson, name)


//- (NSString *)description {
//    return [NSString stringWithFormat:@"localID：%ld | name：%@ | age：%ld | totalScore：%f | job：%@ | createDate：%@ | gender：%ld | stature: %@ | timer: %f", (long)self.localID, self.name, (long)self.age, self.totalScore, self.job, self.createDate, (long)self.gender, self.stature, self.timer];
//}

- (BOOL)isAutoIncrement {
    return YES;
}
@end
