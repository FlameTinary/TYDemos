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
#import "TYLayerDrawView.h"
#import <YYModel.h>
#import "TYLine.h"

@interface ViewController ()
@property(nonatomic, strong) TYLayerDrawView * ldView;
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
    
//    TYQuartzView * qView = [[TYQuartzView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:qView];
    
    TYLayerDrawView * ldView = [[TYLayerDrawView alloc] initWithFrame:self.view.bounds];
    ldView.backgroundColor = [UIColor whiteColor];
    ldView.lineWidth = 10;
    ldView.lineColor = 0x656565;
    [self.view addSubview:ldView];
    _ldView = ldView;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSString * linesString = [self readFromFile];
    
    NSArray * lines;
    if (linesString && linesString.length > 0) {
        lines = [NSArray yy_modelArrayWithClass:TYLine.class json:linesString];
    }
    
    [_ldView drawLines:lines];
}

- (NSString *)readFromFile {
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * fileName = [documentDirectory stringByAppendingPathComponent:@"lines"];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL isExists = [fileManager fileExistsAtPath:fileName];
    if (!isExists) return nil;
    
    NSString * str = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    return str;
}

@end
