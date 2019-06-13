//
//  TYCABaseAnimationViewController.m
//  TYToolSet
//
//  Created by user001 on 2018/9/30.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import "TYCABaseAnimationViewController.h"
#import "TYHeartView.h"
#import "TYProgress.h"
#import "TYDispatchTimer.h"
#import "UIColor+TYColorExtension.h"

@interface TYCABaseAnimationViewController ()
@property(nonatomic, strong)TYProgress *progress; // 倒计时视图
@property(nonatomic, assign)CGFloat countDownTime;
@end

@implementation TYCABaseAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"CABaseAnimation";
    _countDownTime = 1.0;
    //[self animationForHeart];
    [self.view addSubview:self.progress];
    [self startTimer];
    
}

- (void)animationForHeart {
    TYHeartView *heartView = [[TYHeartView alloc] init];
    heartView.frame = CGRectMake(100, 200, 200, 200);
    [self.view addSubview:heartView];
    
    // 给心视图添加心跳动画
    float bigSize = 1.1;
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulseAnimation.duration = 0.25;
    pulseAnimation.toValue = [NSNumber numberWithFloat:bigSize];
    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    // 倒转动画
    pulseAnimation.autoreverses = YES;
    // 设置重复次数为无限大
    pulseAnimation.repeatCount = FLT_MAX;
    // 添加动画到layer
    [heartView.layer addAnimation:pulseAnimation forKey:@"transform.scale"];
}


#pragma mark - Timer
- (void)startTimer {
    [TYDispatchTimer scheduleDispatchTimerWithName:@"progressTimer" timeInterval:1.0 queue:dispatch_get_main_queue() repeats:YES action:^{
        self.progress.duration = 1.0;
//        self.progress.progress = _countDownTime;
        self.progress.fromValue = _countDownTime;
        _countDownTime -= 0.1;
        self.progress.toValue = _countDownTime;
        [self.progress startBasicAnimation];
        if (_countDownTime <= 0) {
            _countDownTime = 1.0;
            //            [TYDispatchTimer cancelAllTimer];
            self.progress.progressColor = [UIColor randomColor];
        }
    }];
}


#pragma mark - lazy
- (TYProgress *)progress {
    if (!_progress) {
        _progress = [[TYProgress alloc] initWithFrame:CGRectMake(50, 100, 200, 10)];
    }
    return _progress;
}

@end
