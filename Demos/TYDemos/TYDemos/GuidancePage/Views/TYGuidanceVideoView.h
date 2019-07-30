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

@protocol TYGuidanceVideoViewDelegate <NSObject>

- (void)guidanceDidEnd;

@end

@interface TYGuidanceVideoView : UIView

@property(nonatomic, assign)id<TYGuidanceVideoViewDelegate> delegate;

- (instancetype)initWithUrl:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
