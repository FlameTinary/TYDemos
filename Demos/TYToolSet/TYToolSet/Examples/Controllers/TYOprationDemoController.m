//
//  TYOprationDemoController.m
//  TYToolSet
//
//  Created by 田宇 on 2019/3/7.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYOprationDemoController.h"
#import "TYOperation.h"

@interface TYOprationDemoController ()

@end

@implementation TYOprationDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self NSInvocationOperationDemo];
    //[self NSBlockOperationDemo];
    //[self TYOperationDemo];
    [self NSInvocationOprationToQueueDemo];
    //[self addOperationWithBlockToQueue];
}

// 使用NSInvocationOpration
- (void)NSInvocationOperationDemo {
    NSLog(@"NSInvocationOperationDemo");
    
    //1. 创建InvocationOpration对象
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
    
    //2. 启动opration
    [op start];
    
}

// 使用NSBlockOpration
- (void)NSBlockOperationDemo {
    NSLog(@"NSBlockOperationDemo");
    //1. 创建BlockOpration对象
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        [self run];
    }];
    //2. 添加额外的子线程任务
    [op addExecutionBlock:^{
        [self executionMethod];
    }];
    //3. 启动
    [op start];
}

// 使用自定义的Operation
- (void)TYOperationDemo {
    TYOperation *op = [[TYOperation alloc] init];
    [op start];
}

//NSInvocationOpration添加到队列中的使用demo
- (void)NSInvocationOprationToQueueDemo {
    //1. 创建InvocationOpration对象
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
    //2. 创建BlockOperation对象
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 4; i++) {
            NSLog(@"%d-blokckOperation的线程--%@", i, [NSThread currentThread]);
        }
    }];
    
    //3. 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // maxConcurrentOperationCount默认为-1,不做限制;1为串行;大于1为并行
    queue.maxConcurrentOperationCount = 1;
    
    [queue addOperation:op1];
    [queue addOperation:op2];
}

//addOperationWithBlockToQueueDemo
- (void)addOperationWithBlockToQueue {
    //1. 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //2. 将任务添加到线程block中
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 4; i++) {
            NSLog(@"当前的线程--%@", [NSThread currentThread]);
        }
    }];
}

// 示例方法
- (void)run {
    NSLog(@"run方法当前线程--%@", [NSThread currentThread]);
}

// 额外的方法
- (void)executionMethod {
    NSLog(@"额外的方法当前线程--%@", [NSThread currentThread]);
}

@end
