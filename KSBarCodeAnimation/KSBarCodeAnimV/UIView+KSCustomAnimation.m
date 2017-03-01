//
//  UIView+KSCustomAnimation.m
//  KSBarCodeAnimation
//
//  Created by 康帅 on 17/3/1.
//  Copyright © 2017年 Bujiaxinxi. All rights reserved.
//

#import "UIView+KSCustomAnimation.h"

@implementation UIView (KSCustomAnimation)

/*
 ** 根据传入的数字码创建条形码图
 */
+(void)generateCodeWithImageView:(UIImageView *)imageView code:(NSString *)code{
    // @"CICode128BarcodeGenerator"  条形码
    // @"CIAztecCodeGenerator"       二维码
    
    NSString *filtername=@"CICode128BarcodeGenerator";
    
    CIFilter *filter=[CIFilter filterWithName:filtername];
    [filter setDefaults];
    
    NSData *data=[code dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    CIImage *outputImage=[filter outputImage];
    CIContext *context=[CIContext contextWithOptions:nil];
    CGImageRef cgImage=[context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *image=[UIImage imageWithCGImage:cgImage scale:1 orientation:UIImageOrientationUp];
    
    CGFloat scaleRate=imageView.frame.size.width/image.size.width;
    
    UIImage *resized=[UIView resizeImage:image withQuality:kCGInterpolationNone rate:scaleRate];
    
    imageView.image = resized;
    
    CGImageRelease(cgImage);
}
+ (UIImage *)resizeImage:(UIImage *)image
             withQuality:(CGInterpolationQuality)quality
                    rate:(CGFloat)rate {
    UIImage *resized = nil;
    CGFloat width    = image.size.width * rate;
    CGFloat height   = image.size.height * rate;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, quality);
    [image drawInRect:CGRectMake(0, 0, width, height)];
    resized = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resized;
}
/*
 ** 将传入的条形码添加空格
 */
+(void)insertBlankWithLable:(UILabel *)lable{
    NSMutableString * str =[NSMutableString stringWithString:lable.text] ;
    NSInteger num = str.length;
    NSInteger  insertNum = num/4;
    NSInteger  remainder =num%4;
    if (remainder<=3) {
        insertNum = insertNum -1;
    }
    for ( int i = 0; i <insertNum; i++) {
        [ str insertString:@" " atIndex:(i+1)*4+i];
    }
    lable.text = str;
}

/*
 ** 将传入的view进行截图
 */
+(UIImage *)getImageWithView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions( view.frame.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return  theImage;
}

/*
 ** 根据isShow判断条形码旋转和还原
 */
+(void)imageViewAnimationWithIsShowView:(UIView *)view IsShow:(BOOL)isShow{
    CGPoint oldCenter = view.center;
    CGPoint newCenter = CGPointMake(mainScreenWidth/2, mainScreenHeight/2);
    CABasicAnimation* rotationAnimation1;
    rotationAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //旋转
    rotationAnimation1.fromValue = [NSNumber numberWithFloat:isShow?0 : M_PI_2];
    rotationAnimation1.toValue = [NSNumber numberWithFloat:isShow? M_PI_2 :0 ];
    CABasicAnimation* rotationAnimation2= [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    // 缩放/恢复
    
    rotationAnimation2.fromValue = [NSNumber numberWithFloat:isShow? 1.0:1.5];
    rotationAnimation2.toValue = [NSNumber numberWithFloat:isShow? 1.5:1.0];
    
    
    
    CABasicAnimation *rotationAnimation3 =
    [CABasicAnimation animationWithKeyPath:@"position"];
    
    //中心位移
    rotationAnimation3.fromValue = [NSValue valueWithCGPoint:isShow?oldCenter:newCenter ];
    rotationAnimation3.toValue = [NSValue valueWithCGPoint: isShow?newCenter:oldCenter ]; // 終点
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    // 动画选项设定
    group.duration = 0.3;
    group.repeatCount = 1;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.animations = [NSArray arrayWithObjects:rotationAnimation1,rotationAnimation2,rotationAnimation3,nil];
    [view.layer addAnimation:group forKey:@"move-rotate-layer"];
}
@end
