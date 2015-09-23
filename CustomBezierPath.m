//
//  CustomBezierPath.m
//  PaintDemo
//
//  Created by Duomai on 15/9/23.
//  Copyright © 2015年 zpf. All rights reserved.
//

#import "CustomBezierPath.h"

@implementation CustomBezierPath

+(instancetype)paintPathWithLineWidth:(CGFloat)lineWidth LineColor:(UIColor*)lineColor startPoint:(CGPoint)startPoint{

    CustomBezierPath * path = [[self alloc] init];
    path.lineWidth = lineWidth;
    path.color = lineColor;
    [path moveToPoint:startPoint];
    
    return path;

}

@end
