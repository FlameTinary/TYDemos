//
//  TYPoint+WCTColumnCoding.mm
//  TYDrawDemo
//
//  Created by Sheldon on 2019/7/27.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYPoint.h"
#import <Foundation/Foundation.h>
#import <WCDB/WCDB.h>
#import <YYModel.h>

@interface TYPoint (WCTColumnCoding) <WCTColumnCoding>
@end

@implementation TYPoint (WCTColumnCoding)

+ (instancetype)unarchiveWithWCTValue:(NSData *)value
{
    return [TYPoint yy_modelWithJSON:value];
}

- (NSData *)archivedWCTValue
{
    return [self yy_modelToJSONData];
}

+ (WCTColumnType)columnTypeForWCDB
{
    return WCTColumnTypeBinary;
}

@end
