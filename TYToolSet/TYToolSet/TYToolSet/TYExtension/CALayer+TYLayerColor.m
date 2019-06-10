//
//  CALayer+TYLayerColor.m
//  TYToolSet
//
//  Created by user001 on 2018/3/28.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import "CALayer+TYLayerColor.h"

@implementation CALayer (TYLayerColor)
- (void)setBorderColorFromUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}
@end
