//
//  CustomPaintView.h
//  PaintDemo
//
//  Created by Duomai on 15/9/23.
//  Copyright © 2015年 zpf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPaintView : UIView
@property(nonatomic,assign)CGFloat lineWidth;
@property(nonatomic,strong)UIColor *  lineColor;

@property (nonatomic, strong) UIImage *image;

-(void)clear;
-(void)unDo;


@end
