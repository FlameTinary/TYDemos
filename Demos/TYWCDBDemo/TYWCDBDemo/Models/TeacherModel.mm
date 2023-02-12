//
//  TeacherModel.mm
//  wcdbTest
//
//  Created by Sheldon on 2020/1/19.
//  Copyright © 2020 sheldon. All rights reserved.
//

#import "TeacherModel+WCTTableCoding.h"
#import "TeacherModel.h"
#import <WCDB/WCDB.h>

@implementation TeacherModel

WCDB_IMPLEMENTATION(TeacherModel)
WCDB_SYNTHESIZE(TeacherModel, name)
WCDB_SYNTHESIZE(TeacherModel, age)
WCDB_SYNTHESIZE(TeacherModel, height)
WCDB_SYNTHESIZE(TeacherModel, _id)

WCDB_PRIMARY_ASC_AUTO_INCREMENT(TeacherModel, age)
  
@end
