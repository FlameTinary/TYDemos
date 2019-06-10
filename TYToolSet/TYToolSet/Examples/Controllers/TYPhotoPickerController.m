//
//  TYPhotoPickerController.m
//  TYToolSet
//
//  Created by user001 on 2018/3/27.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import "TYPhotoPickerController.h"


@interface TYPhotoPickerController ()
@property (nonatomic, strong) UIImageView * imgView;
@end

@implementation TYPhotoPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选取相册";
    [self setUpSubViews];
    
}

- (void)setUpSubViews
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(30, 100, 100, 30);
    [btn addTarget:self action:@selector(selectPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"点击选取照片" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    UIImageView * imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake(30, CGRectGetMaxY(btn.frame), 200, 200);
    [self.view addSubview:imgView];
    self.imgView = imgView;
}

- (void)selectPhoto:(UIButton *)sender
{
    [[TYPhotoPicker sharePicker] selectPhotoSourceWithViewController:self FinishSelectImageBlcok:^(UIImage *image) {
        if (image) {
            [self.imgView setImage:image];
        }
    }];
}


@end
