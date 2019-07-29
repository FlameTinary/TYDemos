//
//  TYLine+WCTTableCoding.h
//  TYDrawDemo
//
//  Created by 田宇 on 2019/7/27.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYLine.h"
#import <WCDB/WCDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYLine (WCTTableCoding)<WCTTableCoding>

WCDB_PROPERTY(lineId)
WCDB_PROPERTY(firstPoint)
WCDB_PROPERTY(endPoint)
WCDB_PROPERTY(points)
WCDB_PROPERTY(color)
WCDB_PROPERTY(width)

@end

NS_ASSUME_NONNULL_END
