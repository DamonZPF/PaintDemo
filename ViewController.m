//
//  ViewController.m
//  PaintDemo
//
//  Created by Duomai on 15/9/23.
//  Copyright © 2015年 zpf. All rights reserved.
//

#import "ViewController.h"
#import "CustomPaintView.h"
#import "MaskView.h"
@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet CustomPaintView *paintView;

- (IBAction)valueChange:(UISlider *)sender;

- (IBAction)changeColor:(id)sender;

- (IBAction)oparation:(UIBarButtonItem *)sender;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



- (IBAction)valueChange:(UISlider *)sender {
    
    self.paintView.lineWidth = sender.value;
    
}

- (IBAction)changeColor:(id)sender {
    
    UIButton * button = (UIButton*)sender;
    self.paintView.lineColor = button.backgroundColor;
    
}

- (IBAction)oparation:(UIBarButtonItem *)sender {
    
    switch (sender.tag) {
        case 1:
            [self.paintView clear]; //清屏
            break;
        case 2:
            [self.paintView unDo];//撤销
            break;
            
        case 3:
              self.paintView.lineColor = [UIColor whiteColor]; //橡皮擦
            break;
            case 4:
            [self selectPhoto]; //照片
            break;
         case 5:
            [self savePhoto] ;//保存
            break;
        default:
            break;
    }
}

-(void)selectPhoto{
    
    UIImagePickerController * pickVC = [[UIImagePickerController alloc] init];
    pickVC.delegate = self;
    pickVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:pickVC animated:YES completion:nil];
}

-(void)savePhoto{
    
    UIGraphicsBeginImageContextWithOptions(self.paintView.bounds.size, NO, 0.0);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    [self.paintView.layer renderInContext:currentContext];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        NSLog(@"保存失败");
    }else{
        NSLog(@"保存成功");
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    
    MaskView * maskView = [[MaskView alloc]initWithFrame:self.paintView.frame];
    maskView.MaskViewBlock = ^(UIImage * image){
        self.paintView.image = image;
    };
    maskView.image = image;
    [self.view addSubview:maskView];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
