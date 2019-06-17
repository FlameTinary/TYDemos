//
//  TYGuidanceVC.m
//  TYDemos
//
//  Created by 田宇 on 2019/6/17.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYGuidanceVC.h"

@interface TYGuidanceVC ()

@property (weak, nonatomic) IBOutlet UIImageView *guidanceImageView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *guidanceTap;
@property (weak, nonatomic) IBOutlet UIWebView *guidanceWebView;

@property(nonatomic, strong) NSArray * guidanceImageArray;
@property(nonatomic, assign) int imageCount;

@end

@implementation TYGuidanceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _guidanceImageArray = @[@"guidance_1", @"guidance_2", @"guidance_3"];
    _guidanceImageView.image = [UIImage imageNamed:_guidanceImageArray[0]];
}

- (IBAction)guidanceTapClick:(UITapGestureRecognizer *)sender {
    
    NSString * currentImageName = [self.guidanceImageView.image accessibilityIdentifier];
    NSString * lastImageName = [_guidanceImageArray lastObject];
    if ([currentImageName isEqualToString:lastImageName]) {
        if (!_guidanceWebView.hidden) return;
        _guidanceWebView.hidden = NO;
        _guidanceWebView.allowsInlineMediaPlayback = YES;
        NSString * guidanceVideoPath = [[NSBundle mainBundle] pathForResource:@"guidanceVideo" ofType:@"mp4"];
        NSURL *url = [NSURL fileURLWithPath:guidanceVideoPath];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        [_guidanceWebView loadRequest:request];
        return;
    };
    
    NSUInteger currentImageIndex = [_guidanceImageArray indexOfObject:currentImageName];
    
    //NSLog(@"current image name: %@, current image index: %ld", currentImageName, currentImageIndex);
    CGPoint point = [sender locationInView:self.guidanceImageView];
//    NSLog(@"点击了(x: %lf, y: %lf)", point.x, point.y);
    if (point.x > 100 && point.x < 300 && point.y > 100 && point.y < 200) { // 判断是否在点击范围之内
        self.guidanceImageView.image = [UIImage imageNamed:_guidanceImageArray[currentImageIndex + 1]];
    }
    
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
