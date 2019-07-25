//
//  TYPoint.h
//  TYDrawDemo
//
//  Created by 田宇 on 2019/7/25.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TYPointType) {
    TYPointTypeStart,
    TYPointTypeMove,
    TYPointTypeEnd,
};

@interface TYPoint : NSObject
@property(nonatomic, assign) TYPointType pointType;
@property(nonatomic, assign) CGFloat x;
@property(nonatomic, assign) CGFloat y;

+ (instancetype)pointWithPoint:(CGPoint)point andType:(TYPointType)type;

@end

NS_ASSUME_NONNULL_END
