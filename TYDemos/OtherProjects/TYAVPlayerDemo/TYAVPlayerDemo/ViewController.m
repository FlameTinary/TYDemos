//
//  ViewController.m
//  TYAVPlayerDemo
//
//  Created by 田宇 on 2019/7/9.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
#import <UIKit/UIKit.h>



@interface XGGesTuresView : UIView

//左下角播放按钮

@property (nonatomic ,strong)UIButton                * leftplayerbutton;

//最小时间

@property (nonatomic ,strong)UILabel                 * mintimelable;

//滑动条

@property (nonatomic ,strong)UISlider                * slider;

//缓冲条

@property (nonatomic ,strong)UIProgressView          * progressview;

//视频总时长

@property (nonatomic ,strong)UILabel                 * maxtimelable;

//全屏按钮

@property (nonatomic ,strong)UIButton                * fullbutton;

//右边中间播放按钮

@property (nonatomic ,strong)UIButton                * rightplayerbutton;

//小菊花

@property (nonatomic ,strong)UIActivityIndicatorView * activity;

//视频出错提示  网络提示 用同一个

//@property (nonatomic ,strong)UILabel                 * errorlable;

//返回按钮

@property (nonatomic ,strong)UIButton                * backbutton;

//标题 可以自己调颜色

@property (nonatomic ,strong)UILabel                 * titlelable;





@end



#import "XGGesTuresView.h"



@implementation XGGesTuresView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self =[super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self creatUI];
        
    }
    
    return self;
    
}



- (void)creatUI{
    
    //左边播放按钮
    
    self.leftplayerbutton  = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.leftplayerbutton setImage:[UIImage imageNamed:@"Stop"] forState:UIControlStateNormal];
    
    [self.leftplayerbutton setImage:[UIImage imageNamed:@"Play"] forState:UIControlStateSelected];
    
    [self addSubview:self.leftplayerbutton];
    
    
    
    //进度时间lable
    
    self.mintimelable               = [[UILabel alloc]init];
    
    self.mintimelable.text          = @"00:00";
    
    self.mintimelable.textColor     = [UIColor whiteColor];
    
    self.mintimelable.textAlignment = NSTextAlignmentCenter;
    
    self.mintimelable.font          = [UIFont systemFontOfSize:14];
    
    [self addSubview:self.mintimelable];
    
    
    
    //缓冲条
    
    self.progressview                   = [[UIProgressView alloc]init];
    
    self.progressview.progressTintColor = [UIColor magentaColor];
    
    [self addSubview:self.progressview];
    
    
    
    //滑动条
    
    self.slider                       = [[UISlider alloc]init];
    
    self.slider.minimumTrackTintColor = [UIColor whiteColor];
    
    self.slider.maximumTrackTintColor = [UIColor clearColor];
    
    [self.slider setThumbImage:[UIImage imageNamed:@"icmpv_thumb_light"] forState:UIControlStateNormal];
    
    [self addSubview:self.slider];
    
    
    
    //总时间lable
    
    self.maxtimelable               = [[UILabel alloc]init];
    
    self.maxtimelable.text          = @"00:00";
    
    self.maxtimelable.textColor     = [UIColor whiteColor];
    
    self.maxtimelable.textAlignment = NSTextAlignmentCenter;
    
    self.maxtimelable.font          = [UIFont systemFontOfSize:14];
    
    [self addSubview:self.maxtimelable];
    
    
    
    //全屏按钮
    
    self.fullbutton        = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.fullbutton setImage:[UIImage imageNamed:@"Rotation"] forState:UIControlStateNormal];
    
    [self addSubview:self.fullbutton];
    
    
    
    //右边播放按钮
    
    self.rightplayerbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.rightplayerbutton setImage:[UIImage imageNamed:@"player_pause_iphone_window"] forState:UIControlStateNormal];
    
    [self.rightplayerbutton setImage:[UIImage imageNamed:@"player_start_iphone_window"] forState:UIControlStateSelected];
    
    [self addSubview:self.rightplayerbutton];
    
    
    
    //小菊花
    
    self.activity        = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    self.activity.color  = [UIColor whiteColor];
    
    [self addSubview:self.activity];
    
    
    
    //视频出错提示
    
    //    self.errorlable               = [[UILabel alloc]init];
    
    //    self.errorlable.text          = @"亲,视频解析出错了!";
    
    //    self.errorlable.textColor     = [UIColor whiteColor];
    
    //    self.errorlable.textAlignment = NSTextAlignmentCenter;
    
    //    self.errorlable.hidden        = YES;
    
    //    [self addSubview:self.errorlable];
    
    
    
    //返回按钮
    
    self.backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.backbutton setImage:[UIImage imageNamed:@"public返回"] forState:UIControlStateNormal];
    
    [self addSubview:self.backbutton];
    
    
    
    //标题
    
    self.titlelable = [[UILabel alloc]init];
    
    self.titlelable.textColor = [UIColor whiteColor];
    
    [self addSubview:self.titlelable];
    
}



- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.leftplayerbutton.frame  = CGRectMake(10, self.frame.size.height - 40, 30, 30);
    
    self.mintimelable.frame      = CGRectMake(CGRectGetMaxX(self.leftplayerbutton.frame), self.frame.size.height - 40, 60, 30);
    
    self.slider.frame            = CGRectMake(CGRectGetMaxX(self.mintimelable.frame), self.frame.size.height - 35, self.frame.size.width - 2 *CGRectGetMaxX(self.mintimelable.frame), 20);
    
    self.progressview.frame      = CGRectMake(self.slider.frame.origin.x + 6, self.slider.frame.origin.y, self.slider.frame.size.width - 12, 2);
    
    self.progressview.center     = self.slider.center;
    
    self.maxtimelable.frame      = CGRectMake(CGRectGetMaxX(self.slider.frame), self.frame.size.height - 40, 60, 30);
    
    self.fullbutton.frame        = CGRectMake(CGRectGetMaxX(self.maxtimelable.frame), self.frame.size.height -40, 30, 30);
    
    self.rightplayerbutton.frame = CGRectMake(self.frame.size.width - 60, self.frame.size.height - 100, 50, 50);
    
    self.activity.frame          = CGRectMake(CGRectGetMidX(self.bounds) - 37*0.5, CGRectGetMidY(self.bounds)-37*0.5, 37, 37);
    
    //self.errorlable.frame        = CGRectMake(self.frame.size.width/ 2 - 100, self.frame.size.height / 2 -10, 200, 20);
    
    self.backbutton.frame        = CGRectMake(0, 0, 30, 30);
    
    self.titlelable.frame        = CGRectMake(CGRectGetMaxX(self.backbutton.frame), CGRectGetMinY(self.backbutton.frame), self.frame.size.width - CGRectGetMaxX(self.backbutton.frame), 30);
    
}



- (void)dealloc{
    
    
    
}

上面这些是提示视图 和 手势视图    下面是主要 用avplayer  来播放   代码可以复制到你的工程里  把类改一下就行

#import <UIKit/UIKit.h>

@protocol XGAVPlayerViewdelegate <NSObject>

//全屏

- (void)XGAVPlayerViewfullScreen:(BOOL)fullscreen;

//返回

- (void)XGAVPlayerViewback;

@end



@interface XGAVPlayerView : UIView

//代理

@property (nonatomic ,weak)id<XGAVPlayerViewdelegate>delegate;

//本地和网络亦可

- (void)setUrl:(NSURL *)url andIsStartplay:(BOOL)isstartplay;

//

- (void)closeplay;

@end





#import "XGAVPlayerView.h"

#import "Reachability.h"

#import "XGGesTuresView.h"

#import <CoreTelephony/CTCall.h>

#import <AVFoundation/AVFoundation.h>

#import <CoreTelephony/CTCallCenter.h>



@interface XGAVPlayerView ()<UIAlertViewDelegate,UIGestureRecognizerDelegate>

//播放工具

@property (nonatomic ,strong)AVPlayer       * player;

//播放图层

@property (nonatomic ,strong)AVPlayerLayer  * playerlayer;

//播放资源对象

@property (nonatomic ,strong)AVPlayerItem   * playeritem;





//手势视图

@property (nonatomic ,strong)XGGesTuresView * gesturesview;

//错误lable

@property (nonatomic ,strong)UILabel        * errorlable;

//重连

@property (nonatomic ,strong)UIButton       * reconnectbutton;





//电话

@property (nonatomic ,strong)CTCallCenter   * telephone;

//播放地址

@property (nonatomic ,strong)NSURL          * playerurl;

//player时间观察者

@property (nonatomic ,strong)id               playTimeObserver;

//是否正在播放

@property (nonatomic ,assign)BOOL             isplaying;

//是否开始播放 可从外界控制

@property (nonatomic ,assign)BOOL             isstartplay;

//网络

@property (nonatomic ,assign)NetworkStatus    netstatus;



@end



@implementation XGAVPlayerView

//初始化

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blackColor];
        
        [self creatAvPlayer];
        
        [self creatUI];
        
        [self addtap];
        
    }
    
    return self;
    
}

//播放管理

- (void)creatAvPlayer{
    
    self.player = [[AVPlayer alloc]init];
    
    self.playerlayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
    self.playerlayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    [self.layer insertSublayer:self.playerlayer atIndex:0];//放到最底层
    
}

//视图

- (void)creatUI{
    
    //错误
    
    self.errorlable               = [[UILabel alloc]init];
    
    self.errorlable.textColor     = [UIColor whiteColor];
    
    self.errorlable.textAlignment = NSTextAlignmentCenter;
    
    self.errorlable.hidden        = YES;
    
    [self addSubview:self.errorlable];
    
    //重连
    
    self.reconnectbutton                 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.reconnectbutton setTitle:@"重 连" forState:UIControlStateNormal];
    
    self.reconnectbutton.backgroundColor = [UIColor greenColor];
    
    self.reconnectbutton.hidden          = YES;
    
    [self.reconnectbutton addTarget:self action:@selector(notreachableclick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.reconnectbutton];
    
    //手势视图
    
    self.gesturesview = [[XGGesTuresView alloc]init];
    
    [self addSubview:self.gesturesview];
    
    self.gesturesview.slider.value          = 0.0;//滑动条初始值
    
    self.gesturesview.progressview.progress = 0.0;//缓冲条初始值
    
    [self.gesturesview.leftplayerbutton  addTarget:self action:@selector(playclick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.gesturesview.fullbutton        addTarget:self action:@selector(fullclick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.gesturesview.rightplayerbutton addTarget:self action:@selector(playclick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.gesturesview.backbutton        addTarget:self action:@selector(backclick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.gesturesview.slider            addTarget:self action:@selector(palyslidertouchdown:) forControlEvents:UIControlEventTouchDown];//按下
    
    [self.gesturesview.slider            addTarget:self action:@selector(palysliderdrop:) forControlEvents:UIControlEventValueChanged];//拖动
    
    [self.gesturesview.slider            addTarget:self action:@selector(palysliderdropfinish:) forControlEvents:UIControlEventTouchUpInside];//点击
    
}

//播放 暂停

- (void)playclick{
    
    self.isplaying ? [self stopplay] :[self startplay];
    
}

//全屏

- (void)fullclick:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(XGAVPlayerViewfullScreen:)]){
        
        [self.delegate XGAVPlayerViewfullScreen:sender.selected];
        
    }
    
}

//返回 如果反回到原始图(竖屏) 记得改变全屏按钮状态  如果返回到上一个控制器 则不需要改变全屏按钮状态 这里自定义

- (void)backclick{
    
    [self stopplay];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(XGAVPlayerViewback)]){
        
        [self.delegate XGAVPlayerViewback];
        
    }
    
}

//按下

- (void)palyslidertouchdown:(UISlider *)sender{
    
    [self.player pause];
    
    if (self.isplaying == YES) {
        
        self.gesturesview.leftplayerbutton.selected  = YES;
        
        self.gesturesview.rightplayerbutton.selected = YES;
        
    }
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(showgesturesview) object:nil];
    
}

//拖动

- (void)palysliderdrop:(UISlider *)sender{
    
    CMTime changetime = CMTimeMakeWithSeconds(sender.value, 1.0);
    
    self.gesturesview.mintimelable.text = [self convertTime:CMTimeGetSeconds(changetime)];
    
}

//拖动结束

- (void)palysliderdropfinish:(UISlider *)sender{
    
    CMTime changetime = CMTimeMakeWithSeconds(sender.value, 1.0);
    
    [self.playeritem seekToTime:changetime completionHandler:^(BOOL finished) {
        
        self.isplaying ? [self startplay] : nil;
        
    }] ;
    
}

//手势

- (void)addtap{
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showgesturesview)];
    
    tap.delegate = self;
    
    [self addGestureRecognizer:tap];
    
}

//手势方法

- (void)showgesturesview{
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(showgesturesview) object:nil];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.gesturesview.hidden      = !self.gesturesview.hidden;
        
        [[UIApplication sharedApplication]setStatusBarHidden:self.gesturesview.hidden withAnimation:UIStatusBarAnimationFade];
        
    } completion:nil];
    
}

//手势代理 用来解决uislider和tap 的手势冲突

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(nonnull UITouch *)touch{
    
    if ([touch.view isKindOfClass:[UISlider class]]) {
        
        return NO;
        
    }
    
    return YES;
    
}

//本地和网络亦可

- (void)setUrl:(NSURL *)url andIsStartplay:(BOOL)isstartplay{//进来优先检查网络
    
    self.isstartplay = isstartplay;
    
    self.playerurl   = url;
    
    NetworkStatus firststatus = [self CheckNowNetWorkStatus];
    
    switch (firststatus) {
            
        case NotReachable:{//进来时没网络
            
            [self notreachable];
            
        }break;
            
        case ReachableViaWiFi:{//进来wifi
            
            [self reachableviawifi:url];
            
        }break;
            
        case ReachableViaWWAN:{//进来时没网络
            
            UIAlertView * firstalert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"当前处于2g/3g/4g模式下,继续播放会产生流量!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            firstalert.tag = 1;
            
            [firstalert show];
            
        }break;
            
        default:
            
            break;
            
    }
    
}

//无网络提示

- (void)notreachable{
    
    [self stopplay];
    
    self.errorlable.hidden = NO;
    
    self.errorlable.text   = @"亲,没有网络!";
    
    self.reconnectbutton.hidden = NO;
    
    self.gesturesview.userInteractionEnabled = NO;
    
}

//刚进来时无网络状态 没有创建self.playeritem 和监听 所以不影响后面的

- (void)notreachableclick{
    
    NetworkStatus reconnect = [self CheckNowNetWorkStatus];
    
    switch (reconnect) {
            
        case NotReachable:{//重连 无网络点击 不做任何反应
            
            NSLog(@"无网络");
            
        }break;
            
        case ReachableViaWiFi:{//wifi
            
            NSLog(@"wifi");
            
        }
            
        case ReachableViaWWAN:{//在流量状态重连 表示用户默认接受了流量状态下播放  wifi就不用说了
            
            [self reachableviawifi:self.playerurl];
            
        }break;
            
        default:
            
            break;
            
    }
    
}

//wifi

- (void)reachableviawifi:(NSURL *)url{
    
    self.errorlable.hidden = YES;
    
    self.reconnectbutton.hidden = YES;
    
    self.gesturesview.userInteractionEnabled = YES;
    
    if ([url.absoluteString hasPrefix:@"http"] ||[url.absoluteString hasPrefix:@"https"]){//网络视频  添加网络监听
        
        self.playeritem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:[url.absoluteString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        [self addnetworkNotification];
        
    }else{//本地
        
        self.playeritem = [AVPlayerItem playerItemWithURL:url];
        
    }
    
    [self.player replaceCurrentItemWithPlayerItem:self.playeritem];
    
    [self addNotification];
    
}

//网络监控

- (void)addnetworkNotification{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(netchange:) name:kReachabilityChangedNotification object:nil];
    
}

//网络状态

- (void)netchange:(NSNotification *)noti{
    
    Reachability * reach = [noti object];
    
    if ([reach isKindOfClass:[Reachability class]]) {
        
        NetworkStatus status = [reach currentReachabilityStatus];
        
        [self updatenetworkstatus:status];
        
    }
    
}

//根据网络 改变播放状态

- (void)updatenetworkstatus:(NetworkStatus)status{
    
    switch (status) {
            
        case NotReachable:{//无网络
            
            [self notreachable];
            
        }break;
            
        case ReachableViaWiFi:{
            
            self.errorlable.hidden = YES;
            
            self.reconnectbutton.hidden = YES;
            
            self.gesturesview.userInteractionEnabled = YES;
            
        }break;
            
        case ReachableViaWWAN:{//2g3g4g
            
            [self stopplay];
            
            UIAlertView * wwanalert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"当前处于2g/3g/4g模式下,继续播放会产生流量!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            wwanalert.tag = 2;
            
            [wwanalert show];
            
        }break;
            
            
            
        default:
            
            break;
            
    }
    
}

//alert代理

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    switch (alertView.tag) {
            
        case 1:{
            
            if (buttonIndex != alertView.cancelButtonIndex) {
                
                [self reachableviawifi:self.playerurl];
                
            }
            
        }break;
            
        case 2:{
            
            if (buttonIndex != alertView.cancelButtonIndex) {
                
                [self startplay];
                
            }
            
        }break;
            
        default:
            
            break;
            
    }
    
}

//通知

- (void)addNotification {
    
    //kvo监听
    
    [self.playeritem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    // 监听loadedTimeRanges属性
    
    [self.playeritem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    // 播放完成通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    // 前台通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    // 后台通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [self monitoringPlayback:self.playeritem];
    
}

//键值观察

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"status"]){//状态
        
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
        
        if (status == AVPlayerStatusReadyToPlay) {
            
            AVPlayerItem *item = (AVPlayerItem *)object;
            
            self.gesturesview.slider.maximumValue = CMTimeGetSeconds(item.duration);// 获取视频长度 设置视频时间
            
            self.gesturesview.maxtimelable.text   = [self convertTime:CMTimeGetSeconds(item.duration)];// 设置视频时间
            
            self.isstartplay ? [self startplay]:[self stopplay];// 进来开始播放 进来暂停暂停
            
        }else if (status == AVPlayerStatusFailed){//当地址不对 无网络时 会走此方法
            
            NSLog(@"AVPlayerStatusFailed");
            
            [self stopplay];
            
            self.errorlable.hidden = NO;
            
            self.errorlable.text   = @"亲,视频解析出错了!";
            
            self.gesturesview.userInteractionEnabled = NO;
            
        }else {
            
            NSLog(@"AVPlayerStatusUnknown");
            
        }
        
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]){
        
        NSTimeInterval timeInterval = [self availableDurationRanges]; // 缓冲时间
        
        CGFloat totalDuration = CMTimeGetSeconds(self.playeritem.duration); // 总时间
        
        [self.gesturesview.progressview setProgress:timeInterval / totalDuration animated:YES];//更新缓冲条
        
    }
    
}

// 相对格林时间

- (NSString *)convertTime:(CGFloat)second {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    if (second / 3600 >= 1) {
        
        [formatter setDateFormat:@"HH:mm:ss"];
        
    } else {
        
        [formatter setDateFormat:@"mm:ss"];
        
    }
    
    NSString *showTimeNew = [formatter stringFromDate:date];
    
    return showTimeNew;
    
}

// 缓冲时间 计算

- (NSTimeInterval)availableDurationRanges {
    
    NSArray *loadedTimeRanges = [self.playeritem loadedTimeRanges]; // 获取item的缓冲数组
    
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue]; // 获取缓冲区域
    
    float startSeconds = CMTimeGetSeconds(timeRange.start);// CMTimeRange 结构体 start duration 表示起始位置 和 持续时间
    
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    
    NSTimeInterval result = startSeconds + durationSeconds; // 计算总缓冲时间 = start + duration
    
    return result;
    
}

//播放完成通知

- (void)playbackFinished:(NSNotification *)notification {
    
    self.playeritem = [notification object];
    
    [self.playeritem seekToTime:kCMTimeZero]; // 跳转到初始
    
    [self stopplay];//暂停
    
    self.gesturesview.hidden = NO;
    
    //[self startplay];//开始  无限循环
    
}

//进入前台

- (void)enterForeground:(NSNotification *)notification {
    
    NSSet * currentsset = self.telephone.currentCalls;
    
    if (currentsset == nil) {
        
        if(!self.isplaying){//切刀后台最后一刻的状态
            
            [self startplay];
            
        }
        
    }
    
}

//进入后台

- (void)enterBackground:(NSNotification *)notification {
    
    [self stopplay];
    
}

// 观察播放进度 每秒执行1次， CMTime 为1秒

- (void)monitoringPlayback:(AVPlayerItem *)item {
    
    __weak typeof(self)WeakSelf = self;
    
    self.playTimeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        
        //当前播放时间  秒
        
        float currentPlayTime = (double)item.currentTime.value/ item.currentTime.timescale;
        
        WeakSelf.gesturesview.slider.value      = currentPlayTime;
        
        WeakSelf.gesturesview.mintimelable.text = [WeakSelf convertTime:currentPlayTime];
        
    }];
    
}

//开始播放

- (void)startplay{
    
    self.isplaying = YES;
    
    [self.player play];
    
    self.gesturesview.leftplayerbutton.selected  = NO;
    
    self.gesturesview.rightplayerbutton.selected = NO;
    
    [self performSelector:@selector(showgesturesview) withObject:nil afterDelay:5.0];
    
}

//暂停播放

- (void)stopplay{
    
    self.isplaying = NO;
    
    [self.player pause];
    
    self.gesturesview.leftplayerbutton.selected  = YES;
    
    self.gesturesview.rightplayerbutton.selected = YES;
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(showgesturesview) object:nil];
    
}

//约束

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.playerlayer.frame     = self.bounds;
    
    self.gesturesview.frame    = self.bounds;
    
    self.errorlable.frame      = CGRectMake(self.frame.size.width/ 2 - 150, self.frame.size.height / 2 -20, 300, 20);
    
    self.reconnectbutton.frame = CGRectMake(self.frame.size.width/ 2 - 30, CGRectGetMaxY(self.errorlable.frame) + 10, 60, 30);
    
}

//第一次进入页面判断网络状态使用

- (NetworkStatus)CheckNowNetWorkStatus{
    
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    
    NSNumber *dataNetworkItemView = nil;
    
    for (id subview in subviews) {
        
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            
            dataNetworkItemView = subview;
            
            break;
            
        }
        
    }
    
    switch ([[dataNetworkItemView valueForKey:@"dataNetworkType"]integerValue]) {
            
        case 0:NSLog(@"No wifi or cellular");
            
            return NotReachable;
            
            break;
            
        case 1:NSLog(@"2G");
            
        case 2:NSLog(@"3G");
            
        case 3:NSLog(@"4G");
            
        case 4:NSLog(@"LTE");
            
            return ReachableViaWWAN;
            
            break;
            
        case 5:NSLog(@"Wifi");
            
            return ReachableViaWiFi;
            
            break;
            
        default:
            
            break;
            
    }
    
    return ReachableViaWiFi;
    
}

////手动释放

//- (void)closeplay{

//    [self.player pause];

//    [self.playeritem removeObserver:self forKeyPath:@"status"];

//    [self.playeritem removeObserver:self forKeyPath:@"loadedTimeRanges"];

//    [[NSNotificationCenter defaultCenter]removeObserver:self];

//    [self.player removeTimeObserver:self.playTimeObserver];

//    self.playTimeObserver = nil;

//    [self.player replaceCurrentItemWithPlayerItem:nil];

//

//}

//自动释放

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    [self.player removeTimeObserver:self.playTimeObserver];
    
    self.playTimeObserver = nil;
    
    [self.player replaceCurrentItemWithPlayerItem:nil];
    
    [self.playeritem removeObserver:self forKeyPath:@"status"];
    
    [self.playeritem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    
}
*/
@end
