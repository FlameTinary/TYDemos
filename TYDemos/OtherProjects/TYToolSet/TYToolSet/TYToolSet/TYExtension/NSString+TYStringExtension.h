//
//  NSString+TYStringExtension.h
//  TYToolSet
//
//  Created by user001 on 2018/3/28.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TYStringExtension)
//时间字符串
- (NSString *)stringToDate;

//返回年月日,时分格式的字符串
- (NSString *)stringToYearMonthDayHourMinuteDate;
/**
 倒计时
 @return 返回时间字符串
 */
- (NSString *)countDownStringWithData;

/**
 返回中文格式的月日时分
 
 @return 返回中文格式的月日时分
 */
- (NSString *)returnChinaTimeData;
//比较两个日期的大小,格式为yyyy-MM-dd HH:mm:ss
+ (NSInteger)compareDate:(NSString *)aDate withDate:(NSString *)bDate;
/**
 //返回自定义格式的字符串
 
 @param dateString 自定义的时间字符串格式,如:@"yyyy-MM-dd HH:mm"
 
 @return return 返回指定格式的时间字符串
 */
- (NSString *)stringToCustomDate:(NSString *)dateString;
//判断内容是否含有中文
- (BOOL)isChinese;
@end
