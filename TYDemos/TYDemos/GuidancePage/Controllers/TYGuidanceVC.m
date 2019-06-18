//
//  TYGuidanceVC.m
//  TYDemos
//
//  Created by 田宇 on 2019/6/17.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYGuidanceVC.h"
#import "TYGuidanceVideoView.h"

@interface TYGuidanceVC ()<TYGuidanceVideoViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *guidanceImageView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *guidanceTap;

@property(nonatomic, strong) TYGuidanceVideoView * videoView;

@property(nonatomic, strong) NSArray * guidanceImageArray;
@property(nonatomic, assign) int imageCount;

@end

@implementation TYGuidanceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _guidanceImageArray = @[@"guidance_1", @"guidance_2", @"guidance_3"];
    _guidanceImageView.image = [UIImage imageNamed:_guidanceImageArray[0]];
    [_guidanceImageView.image setAccessibilityIdentifier:_guidanceImageArray[0]];
}

- (IBAction)guidanceTapClick:(UITapGestureRecognizer *)sender {
    
    NSString * currentImageName = [self.guidanceImageView.image accessibilityIdentifier];
    NSString * lastImageName = [_guidanceImageArray lastObject];
    if ([currentImageName isEqualToString:lastImageName]) {
        if (_videoView) return;
        
        NSString * guidanceVideoPath = [[NSBundle mainBundle] pathForResource:@"guidanceVideo" ofType:@"mp4"];
        NSURL *url = [NSURL fileURLWithPath:guidanceVideoPath];
        
        _videoView = [[TYGuidanceVideoView alloc] initWithUrl:url];
        _videoView.delegate = self;
//        _videoView.frame = CGRectMake(0, 0, 200, 400);
        [self.view addSubview:_videoView];
        
        [_videoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(200);
            make.bottom.mas_equalTo(-300);
            make.left.mas_equalTo(70);
            make.right.mas_equalTo(-70);
        }];
        
        return;
    };
    
    NSUInteger currentImageIndex = [_guidanceImageArray indexOfObject:currentImageName];
    
    //NSLog(@"current image name: %@, current image index: %ld", currentImageName, currentImageIndex);
    CGPoint point = [sender locationInView:self.guidanceImageView];
//    NSLog(@"点击了(x: %lf, y: %lf)", point.x, point.y);
    if (point.x > 100 && point.x < 300 && point.y > 100 && point.y < 200) { // 判断是否在点击范围之内
        self.guidanceImageView.image = [UIImage imageNamed:_guidanceImageArray[currentImageIndex + 1]];
        [self.guidanceImageView.image setAccessibilityIdentifier:_guidanceImageArray[currentImageIndex + 1]];
    }
    
}


#pragma mark - TYGuidanceVideoViewDelegate
- (void)guidanceDidEnd {
    [self dismissViewControllerAnimated:NO completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
