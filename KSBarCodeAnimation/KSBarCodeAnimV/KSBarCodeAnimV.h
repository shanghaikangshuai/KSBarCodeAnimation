//
//  KSBarCodeAnimV.h
//  KSBarCodeAnimation
//
//  Created by 康帅 on 17/3/1.
//  Copyright © 2017年 Bujiaxinxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+KSCustomAnimation.h"

@interface KSBarCodeAnimV : UIView
/*
 * 初始的条形码图
 */
@property(strong,nonatomic)UIImageView * codeImageView;
/*
 * 点击放大后条形码图
 */
@property(strong,nonatomic)UIImageView * enlargeImageView;
/*
 *初始的条形码label
 */
@property(strong,nonatomic)UILabel * codeLabel;
/*
 *条形码
 */
@property(copy,nonatomic)NSString * codeString;
/*
 *点击后的背景View
 */
@property(strong,nonatomic)UIView * bgView;
/*
 *当前view所在的ViewController
 */
@property(strong,nonatomic)UIViewController * vc;

/*
 *初始view添加的按钮
 */
@property(strong,nonatomic)UIButton * toucheButton;
/*
 *当前view添加的按钮
 */
@property(strong,nonatomic)UIButton * bgButton;
@end
