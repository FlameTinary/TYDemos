//
//  ViewController.m
//  TYOperationDemo
//
//  Created by Sheldon on 2019/4/2.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "ViewController.h"
#import "TYOperation.h"

@interface ViewController ()
@property (nonatomic, assign)int ticketCount;
@property (nonatomic, strong)NSLock *lock;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self useInvocationOperation];
    //[self useBlockOperation];
    //[self useTYOperation];
    //[self addOperationToQueue];
    //[self addOperationWithBlockToQueue];
    //[self setMaxConcurrentOperationCount];
    //[self addDependency];
    //[self communication];
    [self ticketWindows];
}

#pragma mark - operation

//NSInvocationOperation使用
- (void)useInvocationOperation {
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationTask1) object:nil];
    [operation start];
}

//NSBlockOperation使用
- (void)useBlockOperation {
    // 创建NSBlockOperation对象
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"useBlockOperation-%@", [NSThread currentThread]);
    }];
    
    //添加额外操作
    [operation addExecutionBlock:^{
        for (int i = 0; i < 100; i++) {
            NSLog(@"Execution1-%@", [NSThread currentThread]);
        }
    }];
    
    [operation start];
}

//自定义TYOperation使用
- (void)useTYOperation {
    TYOperation *operation = [[TYOperation alloc] init];
    [operation start];
}

#pragma mark - queue

//使用addExecutionBlock添加操作
- (void)addOperationToQueue {
    //创建queue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //创建NSInvocationOperation
    NSInvocationOperation *invocationOP = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationTask1) object:NULL];
    
    //创建NSBlockOperation
    NSBlockOperation *blockOP = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"useBlockOperation-%@", [NSThread currentThread]);
    }];
    //添加额外操作
    [blockOP addExecutionBlock:^{
        for (int i = 0; i < 20; i++) {
            NSLog(@"Execution2-%@", [NSThread currentThread]);
        }
    }];
    
    //创建TYOperation
    TYOperation *tyOP = [[TYOperation alloc] init];
    
    //使用 addOperation: 添加所有操作到队列中
    [queue addOperation:invocationOP];
    [queue addOperation:blockOP];
    [queue addOperation:tyOP];
    
    /*结论:
     使用 NSOperation 子类创建操作，并使用 addOperation: 将操作加入到操作队列后能够开启新线程，进行并发执行。
     */
}

//使用addOperationWithBlock添加操作
- (void)addOperationWithBlockToQueue {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
}

/*
 NSOperationQueue串行功能是如何实现的？
 这里有个关键属性 maxConcurrentOperationCount，叫做最大并发操作数。用来控制一个特定队列中可以有多少个操作同时参与并发执行。
 注意：这里 maxConcurrentOperationCount 控制的不是并发线程的数量，而是一个队列中同时能并发执行的最大操作数。而且一个操作也并非只能在一个线程中运行。
 * maxConcurrentOperationCount 默认情况下为-1，表示不进行限制，可进行并发执行。
 * maxConcurrentOperationCount 为1时，队列为串行队列。只能串行执行。
 * maxConcurrentOperationCount 大于1时，队列为并发队列。操作并发执行，当然这个值不应超过系统限制，即使自己设置一个很大的值，系统也会自动调整为 min{自己设定的值，系统设定的默认最大值}。
 */
//设置 MaxConcurrentOperationCount
- (void)setMaxConcurrentOperationCount {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //设置最大并发数
    //queue.maxConcurrentOperationCount = 1;//串行
    //queue.maxConcurrentOperationCount = 2;//并发
    queue.maxConcurrentOperationCount = 7;//并发
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1-%@", [NSThread currentThread]);
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2-%@", [NSThread currentThread]);
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3-%@", [NSThread currentThread]);
        }
    }];
}

/*NSOperation 操作依赖
 NSOperation、NSOperationQueue 能添加操作之间的依赖关系。通过操作依赖，我们可以很方便的控制操作之间的执行先后顺序。NSOperation 提供了3个接口供我们管理和查看依赖。
 * - (void)addDependency:(NSOperation *)op; 添加依赖，使当前操作依赖于操作 op 的完成。
 * - (void)removeDependency:(NSOperation *)op; 移除依赖，取消当前操作对操作 op 的依赖。
 * @property (readonly, copy) NSArray<NSOperation *> *dependencies; 在当前操作开始执行之前完成执行的所有操作对象数组。
 
 */

- (void)addDependency {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1-%@", [NSThread currentThread]);
        }
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2-%@", [NSThread currentThread]);
        }
    }];
    
    [op2 addDependency:op1];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    
    /*结果都是 op1 先执行，op2 后执行*/
}

/*
 // 优先级的取值
 typedef NS_ENUM(NSInteger, NSOperationQueuePriority) {
     NSOperationQueuePriorityVeryLow = -8L,
     NSOperationQueuePriorityLow = -4L,
     NSOperationQueuePriorityNormal = 0,
     NSOperationQueuePriorityHigh = 4,
     NSOperationQueuePriorityVeryHigh = 8
 };
 
 */

//线程间通信
- (void)communication {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2.0];
            NSLog(@"1-%@", [NSThread currentThread]);
        }
        // 回到主线程
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            for (int i = 0; i < 2; i++) {
                [NSThread sleepForTimeInterval:2.0];
                NSLog(@"2-%@", [NSThread currentThread]);
            }
        }];
    }];
}

#pragma mark - selector
- (void)invocationTask1 {
    NSLog(@"useInvocationOperation-%@", [NSThread currentThread]);
}

//售票系统
- (void)ticketWindows {
    
    self.ticketCount = 100;
    self.lock = [[NSLock alloc] init];
    
    //创建两个售卖窗口, 并买票
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    queue1.maxConcurrentOperationCount = 1;
    [queue1 addOperationWithBlock:^{
        //卖票操作
        //[self saleTicketUnsafe];
        [self saleTicketSafe];
    }];
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    queue2.maxConcurrentOperationCount = 1;
    [queue2 addOperationWithBlock:^{
        //卖票操作
        //[self saleTicketUnsafe];
        [self saleTicketSafe];
    }];
}

//卖票操作
- (void)saleTicketUnsafe {
    while (self.ticketCount) {
        NSLog(@"current ticket count: %d", --self.ticketCount);
        [NSThread sleepForTimeInterval:0.5];
    }
    NSLog(@"票已卖完");
}
/*线程安全解决方案：
 可以给线程加锁，在一个线程执行该操作的时候，不允许其他线程进行操作。iOS 实现线程加锁有很多种方式。
 @synchronized、NSLock、NSRecursiveLock、NSCondition、NSConditionLock、pthread_mutex、dispatch_semaphore、OSSpinLock、atomic(property)set/get等等各种方式。
 这里我们使用 NSLock 对象来解决线程同步问题。
 NSLock 对象可以通过进入锁时调用 lock 方法，解锁时调用 unlock 方法来保证线程安全。
 */
- (void)saleTicketSafe {
    [self.lock lock];
    NSLog(@"current thread is:%@", [NSThread currentThread]);
    while (self.ticketCount) {
        NSLog(@"current ticket count: %d", --self.ticketCount);
        [NSThread sleepForTimeInterval:0.5];
    }
    NSLog(@"票已卖完");
    [self.lock unlock];
}


@end
