//
//  TYOperation.m
//  TYToolSet
//
//  Created by 田宇 on 2019/3/7.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYOperation.h"

@implementation TYOperation
//需要执行的任务放在main函数中
- (void)main {
    for (int i = 0; i < 5; i++) {
        NSLog(@"自定义Operation中的线程--%@", [NSThread currentThread]);
    }
}

@end
