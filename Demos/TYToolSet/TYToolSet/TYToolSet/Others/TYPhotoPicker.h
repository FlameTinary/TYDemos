//
//  TYPhotoPicker.h
//  TYToolSet
//
//  Created by user001 on 2018/3/27.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^FinishSelectImageBlcok)(UIImage * image);
@interface TYPhotoPicker : NSObject
+ (instancetype)sharePicker;
- (void)selectPhotoSourceWithViewController:(UIViewController *)viewController FinishSelectImageBlcok:(FinishSelectImageBlcok)finishSelectImageBlock;
@end
