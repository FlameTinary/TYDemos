//
//  TYPresentBaseController.m
//  TYToolSet
//
//  Created by user001 on 2018/3/28.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import "TYPresentBaseController.h"
#import "TYPresentDestinationController.h"



@interface TYPresentBaseController ()<TYPresentDestinationControllerDelegate>

@end

@implementation TYPresentBaseController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 200, 100, 44);
    [btn setTitle:@"present" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick:(UIButton *)btn
{
    TYPresentDestinationController * transitionVc = [TYPresentDestinationController new];
    transitionVc.delegate = self;
    [self presentViewController:transitionVc animated:YES completion:nil];
}

#pragma mark - TYPresentTransitionTwoControllerDelegate
- (void)presentedOneControllerPressedDissmiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
