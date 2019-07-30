//
//  TYProgress.h
//  TYToolSet
//
//  Created by user001 on 2018/9/30.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYProgress : UIView
@property(nonatomic, assign)CGFloat fromValue;
@property(nonatomic, assign)CGFloat toValue;
//@property(nonatomic, assign)CGFloat progress;
//@property(nonatomic, assign)CGFloat progress;
@property(nonatomic, assign)CFTimeInterval duration;

@property(nonatomic, strong)UIColor * bgColor;
@property(nonatomic, strong)UIColor * progressColor;

- (void)startBasicAnimation;
@end
