//
//  UIImage+TYImageExtension.m
//  TYToolSet
//
//  Created by user001 on 2018/3/28.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import "UIImage+TYImageExtension.h"

@implementation UIImage (TYImageExtension)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/** 取消UIImage的渲染模式 */
+ (UIImage *)imageRenderingModeImageNamed:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

//改变图片大小
+(UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize{
    UIGraphicsBeginImageContext(reSize);
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}
//图片质量压缩
+(UIImage*)compressImg:(UIImage*)img quality:(float)qly{
    NSData *data = UIImageJPEGRepresentation(img, qly);
    UIImage *image = [UIImage imageWithData:data];
    return image;
}
//图片虚化处理
+(UIImage *)blurrImage:(UIImage *) _image scale:(float)_scale{
    // Make sure that we have an image to work with
    if (!_image)
        return nil;
    // Create context
    CIContext *context = [CIContext contextWithOptions:nil];
    // Create an image
    CIImage *image = [CIImage imageWithCGImage:_image.CGImage];
    // Set up a Gaussian Blur filter
    CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blurFilter setValue:image forKey:kCIInputImageKey];
    // Get blurred image out
    CIImage *blurredImage = [blurFilter valueForKey:kCIOutputImageKey];
    // Set up vignette filter
    CIFilter *vignetteFilter = [CIFilter filterWithName:@"CIVignette"];
    [vignetteFilter setValue:blurredImage forKey:kCIInputImageKey];
    [vignetteFilter setValue:@(3.f) forKey:@"InputIntensity"];
    // get vignette & blurred image
    CIImage *vignetteImage = [vignetteFilter valueForKey:kCIOutputImageKey];
    //CGFloat scale = [[UIScreen mainScreen] scale];
    CGSize scaledSize = CGSizeMake(_image.size.width * _scale, _image.size.height * _scale);
    CGImageRef imageRef = [context createCGImage:vignetteImage fromRect:(CGRect){CGPointZero, scaledSize}];
    return [UIImage imageWithCGImage:imageRef scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationUp];
}

//绘制图片圆角
- (UIImage*)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(ctx,path.CGPath);
    CGContextClip(ctx);
    [self drawInRect:rect];
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)stretchImageWithFLeftCapWidth:(CGFloat)fLeftCapWidth
                             fTopCapHeight:(CGFloat)fTopCapHeight
                                 tempWidth:(CGFloat)tempWidth
                             sLeftCapWidth:(CGFloat)sLeftCapWidth
                             sTopCapHeight:(CGFloat)sTopCapHeight
{
    UIImage *image1 = [self stretchableImageWithLeftCapWidth:fLeftCapWidth topCapHeight:fTopCapHeight];
    
    CGSize imageSize = self.size;
    CGFloat tw = tempWidth / 2.0 + imageSize.width / 2.0;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(tw, imageSize.height), NO, [UIScreen mainScreen].scale);
    [image1 drawInRect:CGRectMake(0, 0, tw, imageSize.height)];
    UIImage *image2 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image2 stretchableImageWithLeftCapWidth:sLeftCapWidth topCapHeight:sTopCapHeight];
    
}

@end
