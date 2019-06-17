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

@end

@implementation TYGuidanceVideoView

- (instancetype)initWithUrl:(NSURL *)url {
    self = [super init];
    if (self) {
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
        self.playerLayer.player = [AVPlayer playerWithPlayerItem:[AVPlayerItem playerItemWithAsset:asset]];
        [self.player play];
    }
    return self;
}

- (AVPlayer *)player {
    return self.playerLayer.player;
}

- (void)setPlayer:(AVPlayer *)player {
    self.playerLayer.player = player;
}

// Override UIView method
+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayerLayer *)playerLayer {
    return (AVPlayerLayer *)self.layer;
}

@end
