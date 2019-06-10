//
//  UIColor+TYColorExtension.h
//  TYToolSet
//
//  Created by user001 on 2018/3/28.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (TYColorExtension)
//随机颜色
+ (UIColor *)randomColor;
/**
 * 十六进制的颜色值转换为颜色UIColor（带透明度）
 */
+(UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;

/**
 * 十六进制的颜色值转换为颜色UIColor
 */
+(UIColor*) colorWithHex:(NSInteger)hexValue;
@end
