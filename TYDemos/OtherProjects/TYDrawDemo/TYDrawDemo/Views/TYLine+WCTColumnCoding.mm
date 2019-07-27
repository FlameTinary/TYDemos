//
//  TYLine+WCTColumnCoding.mm
//  TYDrawDemo
//
//  Created by 田宇 on 2019/7/27.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYLine.h"
#import <Foundation/Foundation.h>
#import <WCDB/WCDB.h>
#import <YYModel.h>

@interface TYLine (WCTColumnCoding) <WCTColumnCoding>
@end

@implementation TYLine (WCTColumnCoding)

+ (instancetype)unarchiveWithWCTValue:(NSData *)value
{
    return [TYLine yy_modelWithJSON:value];
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
