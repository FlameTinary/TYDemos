//
//  TYOperation.m
//  TYOperationDemo
//
//  Created by Sheldon on 2019/4/2.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYOperation.h"

/*
 可以通过重写 main 或者 start 方法 来定义自己的 NSOperation 对象。重写main方法比较简单，我们不需要管理操作的状态属性 isExecuting 和 isFinished。当 main 执行完返回的时候，这个操作就结束了。
*/

@implementation TYOperation

- (void)main {
    NSLog(@"自定义TYOperation-%@", [NSThread currentThread]);
}

@end
