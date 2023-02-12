//
//  TYLayerDrawView.h
//  TYDrawDemo
//
//  Created by Sheldon on 2019/7/25.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TYLine;

NS_ASSUME_NONNULL_BEGIN

@interface TYLayerDrawView : UIView
//画笔的颜色
@property (nonatomic,assign) UInt32 lineColor;
//画笔的宽度
@property (nonatomic,assign) CGFloat lineWidth;
//是否是橡皮擦
@property (nonatomic,assign) BOOL isErase;


- (void)drawLines:(NSArray<TYLine *> *)lines;
@end

NS_ASSUME_NONNULL_END
