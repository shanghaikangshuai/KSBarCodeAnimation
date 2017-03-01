//
//  UIView+KSCustomAnimation.h
//  KSBarCodeAnimation
//
//  Created by 康帅 on 17/3/1.
//  Copyright © 2017年 Bujiaxinxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodeBarViewTool.h"
#define mainScreenHeight [UIScreen mainScreen].bounds.size.height
#define mainScreenWidth [UIScreen mainScreen].bounds.size.width
@interface UIView (KSCustomAnimation)
/*
 ** 根据传入的数字码创建条形码图
 */
+(void)generateCodeWithImageView:(UIImageView *)imageView code:(NSString *)code;

/*
 ** 将传入的条形码添加空格
 */
+(void)insertBlankWithLable:(UILabel *)lable;

/*
 ** 将传入的view进行截图
 */
+(UIImage *)getImageWithView:(UIView *)view;

/*
 ** 根据isShow判断条形码旋转和还原
 */
+(void)imageViewAnimationWithIsShowView:(UIView *)view IsShow:(BOOL)isShow;
@end

