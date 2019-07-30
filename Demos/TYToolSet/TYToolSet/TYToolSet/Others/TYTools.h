//
//  TYTools.h
//  TYToolSet
//
//  Created by user001 on 2018/3/29.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TYTools : NSObject
/*******************Device相关*******************/
//设备唯一标识符
+ (NSString *)identifierString;
//手机别名： 用户定义的名称
+ (NSString *)userPhoneName;
//设备名称
+ (NSString *)deviceName;
//手机系统版本
+ (NSString *)phoneVersion;
//地方型号  （国际化区域名称）
+ (NSString *)localPhoneModel;
// 当前应用软件版本  比如：1.0.1
+ (NSString *)appCurVersion;
// 当前应用版本号码   int类型
+ (NSString *)appCurVersionNum;
//设备尺寸
+ (CGSize)deviceSize;
//设备分辨率
+ (CGSize)deviceResolutionRatio;
//运营商
+ (NSString *)deviceOperator;
//获取设备型号
- (NSString*)deviceEquipment;
@end
