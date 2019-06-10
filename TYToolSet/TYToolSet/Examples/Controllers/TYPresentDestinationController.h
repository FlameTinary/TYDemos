//
//  TYPresentDestinationController.h
//  TYToolSet
//
//  Created by user001 on 2018/3/28.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import "TYBaseViewController.h"
@protocol TYPresentDestinationControllerDelegate <NSObject>

- (void)presentedOneControllerPressedDissmiss;

@end
@interface TYPresentDestinationController : TYBaseViewController

//代理
@property (nonatomic, weak) id<TYPresentDestinationControllerDelegate> delegate;

@end
