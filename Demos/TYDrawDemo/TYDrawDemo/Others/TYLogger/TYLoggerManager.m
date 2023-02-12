//
//  TYLoggerManager.m
//  TYDrawDemo
//
//  Created by Sheldon on 2019/7/30.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYLoggerManager.h"
#import <CocoaLumberjack.h>

@implementation TYLoggerManager

+ (void)log {
    // 添加DDTTYLogger，你的日志语句将被发送到xcode控制台
//    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    if (@available(iOS 10.0, *)) {
        [DDLog addLogger:[DDOSLogger sharedInstance]];
    } else {
        [DDLog addLogger:[DDASLLogger sharedInstance]];
    }
    
    // 添加DDFileLogger，你的日志语句将写入到一个文件中，默认路径在沙盒的Library/Caches/Logs/目录下，文件名为bundleid+空格+日期.log
    DDFileLogger * fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24;
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
    
    //DDLogInfo(@"log path is: %@", fileLogger.currentLogFileInfo.filePath);
    DDLogInfo(@"App is started");
    
//    DDLogVerbose(@"verbose");
//    DDLogDebug(@"Debug");
//    DDLogInfo(@"info");
//    DDLogWarn(@"warn");
//    DDLogError(@"Error");
}

@end
