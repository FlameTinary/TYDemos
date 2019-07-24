//
//  TYPanView.m
//  TYDrawDemo
//
//  Created by 田宇 on 2019/7/24.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYPanView.h"

@interface TYPanView()
@property(nonatomic, strong) UIPanGestureRecognizer *panGes;
@end

@implementation TYPanView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
        _panGes.maximumNumberOfTouches = 1;
        [self addGestureRecognizer:_panGes];
    }
    return self;
}

- (void)panView:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint p = [panGestureRecognizer locationInView:panGestureRecognizer.view];
    NSLog(@"p.x = %lf, p.y = %lf", p.x, p.y);
}

@end
