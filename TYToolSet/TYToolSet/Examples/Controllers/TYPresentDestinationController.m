//
//  TYPresentDestinationController.m
//  TYToolSet
//
//  Created by user001 on 2018/3/28.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import "TYPresentDestinationController.h"
#import "TYPresentTransitionOne.h"

#define purchaseListH 193

@interface TYPresentDestinationController ()<UIViewControllerTransitioningDelegate>

@end

@implementation TYPresentDestinationController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        //为什么要设置为Custom，在最后说明.
        self.modalPresentationStyle = UIModalPresentationCustom;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 100, 44);
    [btn setTitle:@"dismiss" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)closeView {
    [self dismiss];
}

- (void)dismiss{
    if (_delegate && [_delegate respondsToSelector:@selector(presentedOneControllerPressedDissmiss)]) {
        [_delegate presentedOneControllerPressedDissmiss];
    }
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    //这里我们初始化presentType
    return [TYPresentTransitionOne transitionWithTransitionType:TYPresentTransitionOneTypePresent height:purchaseListH];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    //这里我们初始化dismissType
    return [TYPresentTransitionOne transitionWithTransitionType:TYPresentTransitionOneTypeDismiss height:purchaseListH];
}

@end
