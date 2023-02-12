//
//  TYNoInfoView.h
//  TYWCDBDemo
//
//  Created by Sheldon on 2020/4/17.
//  Copyright © 2020 Sheldon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYNoInfoView : UIView
@property(nonatomic, strong) NSString * text;
@property(nonatomic, strong) NSString * actionText;
@property(nonatomic, strong) void(^actionCallback)(void);
@end

NS_ASSUME_NONNULL_END
