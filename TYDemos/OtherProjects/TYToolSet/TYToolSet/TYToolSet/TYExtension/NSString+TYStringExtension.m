//
//  NSString+TYStringExtension.m
//  TYToolSet
//
//  Created by user001 on 2018/3/28.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import "NSString+TYStringExtension.h"

@implementation NSString (TYStringExtension)

- (NSString *)stringToDate {
    return [self stringToCustomDate:@"yyyy-MM-dd HH:mm:ss"];
}

//返回年月日,时分格式的字符串
- (NSString *)stringToYearMonthDayHourMinuteDate{
    return [self stringToCustomDate:@"yyyy-MM-dd HH:mm"];
}

/**
 //返回自定义格式的字符串
 
 @param dateString 自定义的时间字符串格式
 
 @return return 返回指定格式的时间字符串
 */
- (NSString *)stringToCustomDate:(NSString *)dateString{
    NSDate *timeData = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    //    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    //    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    //    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:dateString];
    NSString *strDate = [dateFormatter stringFromDate:timeData];
    return strDate;
}

//比较两个日期的大小,格式为yyyy-MM-dd HH:mm:ss
+ (NSInteger)compareDate:(NSString *)aDate withDate:(NSString *)bDate{
    NSDateFormatter *dateformater=[[NSDateFormatter alloc]init];
    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateA=[[NSDate alloc]init];
    NSDate *dateB=[[NSDate alloc]init];
    
    dateA=[dateformater dateFromString:aDate];
    dateB=[dateformater dateFromString:bDate];
    NSComparisonResult result=[dateA compare:dateB];
    
    if(result==NSOrderedSame){
        //相等
        return 0;
    }else if (result==NSOrderedAscending){
        //bDate比aDate大
        return 1;
    }else if(result==NSOrderedDescending){
        //bDate比aDate小
        return -1;
    }
    return 2;
}

/**
 倒计时
 */
static  NSDateFormatter *countDownFormatter = nil;
- (NSString *)countDownStringWithData {
    
    NSDate *timeData = [NSDate dateWithTimeIntervalSince1970:ceil([self doubleValue]/1000)];
    
#pragma mark - modify by jianglincen
    
    if (countDownFormatter==nil) {
        
        countDownFormatter = [[NSDateFormatter alloc] init];
        
        [countDownFormatter setDateStyle:NSDateFormatterMediumStyle];
        [countDownFormatter setTimeStyle:NSDateFormatterShortStyle];
        [countDownFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        [countDownFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    NSString *strDate = [countDownFormatter stringFromDate:timeData];
    
    return strDate;
}

- (NSString *)returnChinaTimeData{
    NSDate *timeData = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]/1000];
    //    NSDate *timeData = [NSDate dateWithTimeIntervalSince1970:1511057014];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    //    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:timeData];
    return strDate;
}

//判断内容是否含有中文
- (BOOL)isChinese{
    for(int i=0; i< [self length];i++)
    {
        int a =[self characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}
@end
