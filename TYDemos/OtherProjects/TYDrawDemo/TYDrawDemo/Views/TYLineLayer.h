//
//  TYLineLayer.h
//  TYDrawDemo
//
//  Created by 田宇 on 2019/7/25.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TYBezierPath.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYLineLayer : CALayer
@property(nonatomic, assign) UInt32 lineColor;
@property(nonatomic, assign) CGFloat lineWidth;
@property(nonatomic, strong) TYBezierPath *bezierPath;
@end

NS_ASSUME_NONNULL_END
