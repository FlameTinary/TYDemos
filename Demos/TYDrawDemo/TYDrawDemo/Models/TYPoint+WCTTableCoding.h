//
//  TYPoint+WCTTableCoding.h
//  TYDrawDemo
//
//  Created by Sheldon on 2019/7/27.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYPoint.h"
#import <WCDB/WCDB.h>

@interface TYPoint (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(pointId)
WCDB_PROPERTY(PointType)
WCDB_PROPERTY(x)
WCDB_PROPERTY(y)

@end
