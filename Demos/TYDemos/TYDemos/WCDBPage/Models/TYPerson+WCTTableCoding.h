//
//  TYPerson+WCTTableCoding.h
//  TYDemos
//
//  Created by 田宇 on 2019/6/15.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYPerson.h"
#import <WCDB/WCDB.h>

@interface TYPerson (WCTTableCoding) <WCTTableCoding>

//WCDB_PROPERTY用于在头文件中声明绑定到数据库表的字段,写在分类里,不写在.h里面,这样view和controller不会 引入导入<WCDB/WCDB.h>的文件

WCDB_PROPERTY(localID)
WCDB_PROPERTY(name)
WCDB_PROPERTY(age)
WCDB_PROPERTY(createDate)
WCDB_PROPERTY(gender)

@end
