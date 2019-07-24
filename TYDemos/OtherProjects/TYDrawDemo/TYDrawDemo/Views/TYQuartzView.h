//
//  TYQuartzView.h
//  TYDrawDemo
//
//  Created by 田宇 on 2019/7/24.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYQuartzView : UIView
//画笔的颜色
@property (nonatomic,copy) UIColor *lineColor;
@property (nonatomic,assign) CGFloat lineWidth;
//是否是橡皮擦
@property (nonatomic,assign) BOOL isErase;
@end

NS_ASSUME_NONNULL_END
