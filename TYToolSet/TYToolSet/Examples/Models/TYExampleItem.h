//
//  TYExampleItem.h
//  TYToolSet
//
//  Created by user001 on 2018/3/27.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYExampleItem : NSObject

@property (nonatomic, copy) NSString  * title;

@property (nonatomic, strong) Class itemClass;

+ (instancetype)itemWithTitle:(NSString *)title object:(Class)itemClass;

@end
