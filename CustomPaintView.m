//
//  CustomPaintView.m
//  PaintDemo
//
//  Created by Duomai on 15/9/23.
//  Copyright © 2015年 zpf. All rights reserved.
//

#import "CustomPaintView.h"
#import "CustomBezierPath.h"
@interface CustomPaintView()

@property(nonatomic,strong)NSMutableArray * pathArray;
@property(nonatomic,strong)CustomBezierPath * bezierPath;
@end

@implementation CustomPaintView


-(void)awakeFromNib{
    
    self.lineWidth = 2;
}

-(NSMutableArray*)pathArray{
    if (_pathArray == nil) {
        _pathArray = [NSMutableArray array];
    }
    return _pathArray;
}


-(CGPoint)pointWithTouches:(NSSet*)touches{
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    return point;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint point = [self pointWithTouches:touches];
    CustomBezierPath * path = [CustomBezierPath paintPathWithLineWidth:self.lineWidth LineColor:self.lineColor startPoint:point];
    
    self.bezierPath = path;
    
    [self.pathArray addObject:path];
   
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    CGPoint endPoint = [self pointWithTouches:touches];
    [self.bezierPath addLineToPoint:endPoint];
    [self setNeedsDisplay];
    
}

-(void)drawRect:(CGRect)rect{
    for (CustomBezierPath * path in self.pathArray) {
        if ([path isKindOfClass:[UIImage class]]) {
            UIImage * image = (UIImage*)path;
            [image drawAtPoint:CGPointZero];
        }else{
            [path.color set];
            [path stroke];
        }

    }
}


-(void)clear{
    [self.pathArray removeAllObjects];
    [self setNeedsDisplay];
}
-(void)unDo{
    [self.pathArray removeLastObject];
    [self setNeedsDisplay];
}

-(void)setImage:(UIImage *)image{
    _image = image;
    
    [self.pathArray addObject:image];
    
    [self setNeedsDisplay];
}


@end
