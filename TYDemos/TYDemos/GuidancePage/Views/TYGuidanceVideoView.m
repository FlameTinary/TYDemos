//
//  TYGuidanceVideoView.m
//  TYDemos
//
//  Created by 田宇 on 2019/6/17.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYGuidanceVideoView.h"

@interface TYGuidanceVideoView()

@property (readonly) AVPlayerLayer *playerLayer;

@property(nonatomic, strong) UILabel * countDownLbl;
@property(nonatomic, strong) UIButton * againBtn;
@property(nonatomic, strong) UIButton * exitBtn;
@property(nonatomic, strong) id playerObserver;

@end

@implementation TYGuidanceVideoView

- (instancetype)initWithUrl:(NSURL *)url {
    self = [super init];
    if (self) {
        [self setUpUI];
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
        AVPlayerItem * playerItem = [AVPlayerItem playerItemWithAsset:asset];
        //播放完成通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayDidEnd)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:nil];
        self.playerLayer.player = [AVPlayer playerWithPlayerItem:playerItem];
        self.playerLayer.videoGravity = AVLayerVideoGravityResize;
        [self.playerLayer.player play];
        __weak typeof(self) weakSelf = self;
        _playerObserver = [self.playerLayer.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            // 当前的播放时间
            NSTimeInterval currentTime = CMTimeGetSeconds(weakSelf.playerLayer.player.currentTime);
            // 总时间
            NSTimeInterval totalTime = CMTimeGetSeconds(weakSelf.playerLayer.player.currentItem.duration);
            NSLog(@"current time: %lf", currentTime);
            NSLog(@"total time: %lf", totalTime);
            weakSelf.countDownLbl.text = [NSString stringWithFormat:@"%ld", (long)(totalTime - currentTime)];
        }];
    }
    return self;
}

//监听回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    AVPlayerItem *playerItem = (AVPlayerItem *)object;

    if ([keyPath isEqualToString:@"loadedTimeRanges"]){

    }else if ([keyPath isEqualToString:@"status"]){
        if (playerItem.status == AVPlayerItemStatusReadyToPlay){
            NSLog(@"playerItem is ready");
            [self.playerLayer.player play];
        } else{
            NSLog(@"load break");
        }
    }
}

- (void)moviePlayDidEnd {
    NSLog(@"视频播放完成");
    _againBtn.hidden = NO;
    _exitBtn.hidden = NO;
}

// Override UIView method
+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayerLayer *)playerLayer {
    return (AVPlayerLayer *)self.layer;
}


//视频重播
-(void)rerunPlayVideo{
    if (!self.playerLayer.player) {
        return;
    }
    CGFloat a=0;
    NSInteger dragedSeconds = floorf(a);
    CMTime dragedCMTime = CMTimeMake(dragedSeconds, 1);
    [self.playerLayer.player seekToTime:dragedCMTime];
    [self.playerLayer.player play];
}

#pragma mark - button click
- (void)againBtnClick {
    _againBtn.hidden = YES;
    _exitBtn.hidden = YES;
    [self rerunPlayVideo];
}

- (void)exitBtnClick {
    
}


#pragma mark - setup UI
- (void)setUpUI {
    _countDownLbl = [[UILabel alloc] init];
    _countDownLbl.textColor = [UIColor whiteColor];
    _countDownLbl.font = [UIFont systemFontOfSize:16.0f];
    _countDownLbl.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_countDownLbl];
    
    _againBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _againBtn.hidden = YES;
    [_againBtn setTitle:@"没看懂，再看一遍" forState:UIControlStateNormal];
    [_againBtn setBackgroundColor:[UIColor lightGrayColor]];
    [_againBtn addTarget:self action:@selector(againBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_againBtn];
    
    _exitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _exitBtn.hidden = YES;
    [_exitBtn setTitle:@"看懂了" forState:UIControlStateNormal];
    [_exitBtn setBackgroundColor:[UIColor redColor]];
    [_exitBtn addTarget:self action:@selector(exitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_exitBtn];
    
    [_countDownLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.width.height.mas_equalTo(50);
    }];
    
    [_againBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.height.mas_equalTo(30);
        make.width.equalTo(self.exitBtn.mas_width);
        make.right.equalTo(self.exitBtn.mas_left).offset(-20);
    }];
    
    [_exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(0);
        make.height.equalTo(self.againBtn.mas_height);
        make.width.equalTo(self.againBtn.mas_width);
    }];
    
}

- (void)dealloc {
    NSLog(@"销毁");
    if (_playerObserver) {
        [self.playerLayer.player removeTimeObserver:_playerObserver];
    }
}

@end
