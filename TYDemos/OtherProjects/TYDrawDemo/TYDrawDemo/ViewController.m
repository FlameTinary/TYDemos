//
//  ViewController.m
//  TYDrawDemo
//
//  Created by 田宇 on 2019/7/23.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "ViewController.h"
#import "TYPanView.h"
#import "TYBezierPathDrawView.h"
#import "TYQuartzView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    TYBezierDrawView * bezierView = [[TYBezierDrawView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
//    [self.view addSubview:bezierView];
    
//    TYPanView * panView = [[TYPanView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:panView];
    
//    TYBezierPathDrawView * bdView = [[TYBezierPathDrawView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:bdView];
    
    TYQuartzView * qView = [[TYQuartzView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:qView];
    
    
}


@end
