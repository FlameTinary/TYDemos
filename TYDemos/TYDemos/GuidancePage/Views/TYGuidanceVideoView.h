//
//  TYGuidanceVideoView.h
//  TYDemos
//
//  Created by 田宇 on 2019/6/17.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYGuidanceVideoView : UIView

//@property(nonatomic, strong) AVPlayer *player;

- (instancetype)initWithUrl:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
