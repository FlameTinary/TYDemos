//
//  TYPresentTransitionOne.h
//  TYToolSet
//
//  Created by user001 on 2018/3/28.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, TYPresentTransitionOneType) {
    TYPresentTransitionOneTypePresent = 0,//管理present动画
    TYPresentTransitionOneTypeDismiss//管理dismiss动画
};
@interface TYPresentTransitionOne : NSObject<UIViewControllerAnimatedTransitioning>
//根据定义的枚举初始化的两个方法
+ (instancetype)transitionWithTransitionType:(TYPresentTransitionOneType)type height:(CGFloat)height;
- (instancetype)initWithTransitionType:(TYPresentTransitionOneType)type height:(CGFloat)height;
@end
