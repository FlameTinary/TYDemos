//
//  TYExampleItem.m
//  TYToolSet
//
//  Created by user001 on 2018/3/27.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import "TYExampleItem.h"

@implementation TYExampleItem

+ (instancetype)itemWithTitle:(NSString *)title object:(Class)itemClass
{
    TYExampleItem * item = [[TYExampleItem alloc] init];
    item.title = title;
    item.itemClass = itemClass;
    return item;
}

@end
