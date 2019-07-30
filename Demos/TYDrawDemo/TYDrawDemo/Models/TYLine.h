//
//  TYLine.h
//  TYDrawDemo
//
//  Created by 田宇 on 2019/7/25.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYPoint.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYLine : NSObject
@property(nonatomic, readonly, assign) NSInteger lineId;
@property(nonatomic, readonly, strong) TYPoint * firstPoint;
@property(nonatomic, readonly, strong) TYPoint * endPoint;
@property(nonatomic, copy, readonly) NSArray<TYPoint *> * points;
@property(nonatomic, assign) UInt32 color;
@property(nonatomic, assign) float width;

- (void)addPoint:(TYPoint *)point;
- (void)addPointToFirst:(TYPoint *)point;
- (void)addPointToEnd:(TYPoint *)point;
- (void)addPoint:(TYPoint *)point atIndex:(int)index;

@end

NS_ASSUME_NONNULL_END
