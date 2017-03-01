//
//  ViewController.m
//  KSBarCodeAnimation
//
//  Created by 康帅 on 17/3/1.
//  Copyright © 2017年 Bujiaxinxi. All rights reserved.
//

#import "ViewController.h"
#import "KSBarCodeAnimV.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.codeBarView];
    self.codeBarView.codeString = @"123321123454213344";
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 300, mainScreenWidth, 20)];
    titleLabel.text = @"请扫描";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
}

-(KSBarCodeAnimV *)codeBarView{
    if (!_codeBarView) {
        _codeBarView = [[KSBarCodeAnimV alloc]initWithFrame:CGRectMake(0, 100,mainScreenWidth, 150)];
    }
    return _codeBarView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
