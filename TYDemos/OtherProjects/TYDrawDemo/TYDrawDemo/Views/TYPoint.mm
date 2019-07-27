//
//  TYPoint.mm
//  TYDrawDemo
//
//  Created by 田宇 on 2019/7/27.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYPoint+WCTTableCoding.h"
#import "TYPoint.h"
#import <WCDB/WCDB.h>
#import <YYModel.h>

@implementation TYPoint

+ (instancetype)pointWithPoint:(CGPoint)point andType:(TYPointType)type {
    TYPoint *p = [[self alloc] init];
    p.x = point.x;
    p.y = point.y;
    p.pointType = type;
    return p;
}

-(NSString *)description {
    return [self yy_modelToJSONString];
}

WCDB_IMPLEMENTATION(TYPoint)
WCDB_SYNTHESIZE_COLUMN(TYPoint, pointId, "id") // Custom column name
WCDB_SYNTHESIZE(TYPoint, pointType)
WCDB_SYNTHESIZE(TYPoint, x)
WCDB_SYNTHESIZE(TYPoint, y)

WCDB_PRIMARY_ASC_AUTO_INCREMENT(TYPoint, pointId)

@end
