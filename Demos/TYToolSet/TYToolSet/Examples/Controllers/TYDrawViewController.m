//
//  TYDrawViewController.m
//  TYToolSet
//
//  Created by user001 on 2018/3/28.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import "TYDrawViewController.h"
#import "TYToolSet.h"

@interface TYDrawViewController ()

@end

@implementation TYDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"绘制文字";
    
    TYDrawingView * drawView = [TYDrawingView new];
    drawView.frame = CGRectMake(100, 200, 200, 44);
    drawView.title = @"我是绘制的文字";
    [self.view addSubview:drawView];
}

@end
