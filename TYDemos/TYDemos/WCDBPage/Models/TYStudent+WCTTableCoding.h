//
//  TYStudent+WCTTableCoding.h
//  TYDemos
//
//  Created by 田宇 on 2019/6/15.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYStudent.h"
#import <WCDB/WCDB.h>

@interface TYStudent (WCTTableCoding) <WCTTableCoding>

/********继承的类必须重新映射*********/
WCDB_PROPERTY(localID)
WCDB_PROPERTY(name)
WCDB_PROPERTY(age)
WCDB_PROPERTY(createDate)
WCDB_PROPERTY(gender)
/********继承的类必须重新映射*********/

WCDB_PROPERTY(job)
WCDB_PROPERTY(totalScore)
WCDB_PROPERTY(stature)
WCDB_PROPERTY(timer)
WCDB_PROPERTY(testDic)

@end
