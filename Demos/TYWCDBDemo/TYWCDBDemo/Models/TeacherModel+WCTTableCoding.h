//
//  TeacherModel+WCTTableCoding.h
//  wcdbTest
//
//  Created by 田宇 on 2020/1/19.
//  Copyright © 2020 sheldon. All rights reserved.
//

#import "TeacherModel.h"
#import <WCDB/WCDB.h>

@interface TeacherModel (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(name)
WCDB_PROPERTY(age)
WCDB_PROPERTY(height)
WCDB_PROPERTY(_id)

@end
