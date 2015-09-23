//
//  CustomBezierPath.h
//  PaintDemo
//
//  Created by Duomai on 15/9/23.
//  Copyright © 2015年 zpf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBezierPath : UIBezierPath

@property(nonatomic,strong)UIColor * color;

+(instancetype)paintPathWithLineWidth:(CGFloat)lineWidth LineColor:(UIColor*)lineColor startPoint:(CGPoint)startPoint;

@end
