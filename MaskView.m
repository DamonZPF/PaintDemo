//
//  MaskView.m
//  PaintDemo
//
//  Created by Duomai on 15/9/23.
//  Copyright © 2015年 zpf. All rights reserved.
//

#import "MaskView.h"
#import "UIImage+Extention.h"
@interface MaskView()<UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation MaskView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupImageView];
        
        [self addGestureRecognizerAction];
    }
    return self;
}

-(void)setImage:(UIImage *)image{
    _image = image;
    
    self.imageView.image = image;
}

-(void)setupImageView{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    self.imageView = imageView;
}

-(void)addGestureRecognizerAction{
    [self addLongGesture];
    
    [self addPinch];
    
    [self addRoation];
}

-(void)addLongGesture{

    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.imageView addGestureRecognizer:longPress];
}


-(void)addPinch{
    UIPinchGestureRecognizer * pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAcion:)];
    pinchGesture.delegate = self;
    [self.imageView addGestureRecognizer:pinchGesture];
}

-(void)addRoation{
    
    UIRotationGestureRecognizer  * rotation = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationAction:)];
    [self.imageView addGestureRecognizer:rotation];
}


-(void)longPressAction:(UILongPressGestureRecognizer*)gesture{
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3 animations:^{
            self.imageView.alpha = 0.3;
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.5 animations:^{
                self.imageView.alpha = 1.0;
            } completion:^(BOOL finished) {
                
                UIImage * image = [UIImage imageWithCaptureView:self];
                if (self.MaskViewBlock) {
                    self.MaskViewBlock(image);
                }
                
                [self removeFromSuperview];
                
            }];
        }];
    }

}

-(void)pinchAcion:(UIPinchGestureRecognizer*)gesture{

    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, gesture.scale, gesture.scale);
    
    gesture.scale = 1;
}

-(void)rotationAction:(UIRotationGestureRecognizer*)gesture{

    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, gesture.rotation);
    gesture.rotation = 0;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

@end
