//
//  TYTools.m
//  TYToolSet
//
//  Created by user001 on 2018/3/29.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import "TYTools.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "sys/utsname.h"

@implementation TYTools

/*******************Device相关*******************/

//设备唯一标识符
+ (NSString *)identifierString
{
    NSString *identifierStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return identifierStr;
}
//手机别名： 用户定义的名称
+ (NSString *)userPhoneName
{
    NSString* userPhoneName = [[UIDevice currentDevice] name];
    return userPhoneName;
}
//设备名称
+ (NSString *)deviceName
{
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    return deviceName;
}
//手机系统版本
+ (NSString *)phoneVersion
{
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    return phoneVersion;
}
//地方型号  （国际化区域名称）
+ (NSString *)localPhoneModel
{
    NSString* localPhoneModel = [[UIDevice currentDevice] localizedModel];
    return localPhoneModel;
}
// 当前应用软件版本  比如：1.0.1
+ (NSString *)appCurVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 当前应用软件版本  比如：1.0.1
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return appCurVersion;
}
// 当前应用版本号码   int类型
+ (NSString *)appCurVersionNum
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
    return appCurVersionNum;
}
//设备尺寸
+ (CGSize)deviceSize
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    return size;
}
//设备分辨率
+ (CGSize)deviceResolutionRatio
{
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    CGSize size = [TYTools deviceSize];
    return CGSizeMake(size.width*scale_screen, size.height*scale_screen);
}

//运营商
+ (NSString *)deviceOperator
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = info.subscriberCellularProvider;
    return carrier.carrierName;
}
//获取设备型号
- (NSString*)deviceEquipment
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    
    return deviceString;
}

@end
