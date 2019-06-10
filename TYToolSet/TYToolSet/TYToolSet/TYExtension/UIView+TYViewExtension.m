//
//  UIView+TYViewExtension.m
//  TYToolSet
//
//  Created by user001 on 2018/3/28.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import "UIView+TYViewExtension.h"

@implementation UIView (TYViewExtension)
-(void)setTy_x:(CGFloat)ty_x
{
    CGRect tempRect = self.frame;
    tempRect.origin.x = ty_x;
    self.frame = tempRect;
}

-(CGFloat)ty_x
{
    return self.frame.origin.x;
}

-(void)setTy_y:(CGFloat)ty_y
{
    CGRect tempR = self.frame;
    tempR.origin.y = ty_y;
    self.frame = tempR;
}

-(CGFloat)ty_y
{
    return self.frame.origin.y;
}

-(void)setTy_width:(CGFloat)ty_width
{
    CGRect tempR = self.frame;
    tempR.size.width = ty_width;
    self.frame = tempR;
}

-(CGFloat)ty_width{
    
    return self.frame.size.width;
}
-(void)setTy_height:(CGFloat)ty_height
{
    CGRect tempR = self.frame;
    tempR.size.height = ty_height;
    self.frame = tempR;
}
-(CGFloat)ty_height
{
    return self.frame.size.height;
}
-(void)setTy_size:(CGSize)ty_size
{
    CGRect tempR = self.frame;
    tempR.size = ty_size;
    self.frame = tempR;
    
}
- (CGSize)ty_size
{
    return self.frame.size;
}
-(void)setTy_centerX:(CGFloat)ty_centerX
{
    CGPoint center = self.center;
    center.x = ty_centerX;
    self.center = center;
}
-(CGFloat)ty_centerX
{
    return self.center.x;
}
-(void)setTy_centerY:(CGFloat)ty_centerY
{
    CGPoint center = self.center;
    center.y = ty_centerY;
    self.center = center;
}
-(CGFloat)ty_centerY
{
    return self.center.y;
}
@end
