//
//  KSBarCodeAnimV.m
//  KSBarCodeAnimation
//
//  Created by 康帅 on 17/3/1.
//  Copyright © 2017年 Bujiaxinxi. All rights reserved.
//

#import "KSBarCodeAnimV.h"
#import "UIView+KSCustomAnimation.h"

static CGFloat  codeLabelHeight =  20.0f;

@interface KSBarCodeAnimV (){
    BOOL _isShow;
}

@end
@implementation KSBarCodeAnimV
/*
 ** 构造方法
 */
-(instancetype)init{
    self=[super init];
    if (self) {
        [self commonInit];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}
/*
 ** 初始化参数
 */
-(void)commonInit{
    _isShow=NO;
    self.backgroundColor  = [UIColor whiteColor];
    
    [self addSubview:self.codeImageView];
    [self addSubview:self.codeLabel];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(switchAnimation)];
    [self addGestureRecognizer:tap];
}
/*
 ** 切换放大和还原动画
 */
-(void)switchAnimation{
    _isShow=!_isShow;
    
    if (_isShow) {
        self.vc  = [CodeBarViewTool viewControllerWithView:self];
        [self.vc.view addSubview:self.bgView];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(switchAnimation)];
        [self.bgView addGestureRecognizer:tap];
        
        CGRect  viewFrame = [self convertRect:self.bounds toView:nil];
        UIImage  * enlargeImage = [UIView getImageWithView:self];
        self.enlargeImageView = [[UIImageView alloc]initWithFrame:viewFrame];
        self.enlargeImageView.image = enlargeImage;
        [self.bgView addSubview:self.enlargeImageView];
        self.bgView.backgroundColor = [UIColor whiteColor];
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    for (UIView *v in self.bgView.subviews) {
                        [v removeFromSuperview];
                    }
                    [self.bgView removeFromSuperview];
                });
        });
    }
    
    [UIView imageViewAnimationWithIsShowView:self.enlargeImageView IsShow:_isShow];
}

#pragma Setter
-(void)setCodeString:(NSString *)codeString{
    self.codeLabel.text = codeString;
    [UIView insertBlankWithLable:self.codeLabel];
    [UIView generateCodeWithImageView:self.codeImageView code:codeString];
}

#pragma 懒加载
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,mainScreenWidth ,mainScreenHeight)];
    }
    
    return _bgView;
}
-(UIImageView *)codeImageView{
    if (!_codeImageView) {
        _codeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-codeLabelHeight)];
    }
    return _codeImageView;
}
-(UILabel *)codeLabel{
    if (!_codeLabel) {
        _codeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.codeImageView.frame),CGRectGetWidth(self.frame), codeLabelHeight)];
    }
    _codeLabel.textAlignment = NSTextAlignmentCenter;
    _codeLabel.textColor = [UIColor blackColor];
    return _codeLabel;
}

@end
