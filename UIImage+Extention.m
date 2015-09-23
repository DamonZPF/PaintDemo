//
//  UIImage+Extention.m
//  PaintDemo
//
//  Created by Duomai on 15/9/23.
//  Copyright © 2015年 zpf. All rights reserved.
//

#import "UIImage+Extention.h"

@implementation UIImage (Extention)
+(UIImage*)imageWithCaptureView:(UIView*)view{
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:currentContext];
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
