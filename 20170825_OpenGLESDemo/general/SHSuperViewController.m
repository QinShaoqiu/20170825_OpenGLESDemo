//
//  SHSuperViewController.m
//  SmartHome
//
//  Created by qinshaoqiu on 17/6/10.
//  Copyright © 2017年 guet215. All rights reserved.
//

#import "SHSuperViewController.h"

@interface SHSuperViewController ()

@end

@implementation SHSuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initMyNavigationBar];
}


- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}


#pragma mark -返回
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:^{ }];
    
}


//导航栏
- (void)initMyNavigationBar{
    self.myNavigationBar = [[UIView alloc] initWithFrame:(CGRect){0,0,KWidth,64}];
    [self.view addSubview:self.myNavigationBar];
    [self.myNavigationBar setBackgroundColor:UIColorFromRGBHex(0xff99ff)];//0x6fa7ed 0x770000 0xff99ff 0x21b8bf
    [self.view bringSubviewToFront:self.myNavigationBar];
    self.myNavigationBar.alpha = 1.0;
}


//设置标题
- (void)setNavTitleBtnTitle:(NSString *)title{
    self.navTitleBtn = [[UIButton alloc] initWithFrame:(CGRect){65.0f, 20.0f, KWidth - 130, 44.0f}];
    [self.navTitleBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [self.navTitleBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [self.myNavigationBar addSubview:self.navTitleBtn];
    [self.navTitleBtn setTitle:title forState:UIControlStateNormal];
}


//设置标题图片
- (void)setNavTitleBtnImage:(UIImage *)image{
    self.navTitleBtn = [[UIButton alloc] initWithFrame:(CGRect){(KWidth - 40)/2,20,44,44}];
    [self.myNavigationBar addSubview:self.navTitleBtn];
    [self.navTitleBtn setBackgroundImage:image forState:UIControlStateNormal];
}


//设置左按钮标题
- (void)setNavBackBtnTitle:(NSString *)title{
    self.navBackBtn = [[UIButton alloc] initWithFrame:(CGRect){5,20,44,44}];
    [self.navBackBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.navBackBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [self.myNavigationBar addSubview:self.navBackBtn];
    [self.navBackBtn setTitle:title forState:UIControlStateNormal];
    
    [self.navBackBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
}


//设置左按钮图片
- (void)setNavBackBtnImage:(UIImage *)image{
    self.navBackBtn = [[UIButton alloc] initWithFrame:(CGRect){0,20,44,44}];
    [self.myNavigationBar addSubview:self.navBackBtn];
    [self.navBackBtn setBackgroundImage:image forState:UIControlStateNormal];
    self.navBackBtn.imageView.contentMode = UIViewContentModeScaleToFill;
    
    [self.navBackBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
}


//设置右按钮标题
- (void)setNavRightBtnTitle:(NSString *)title{
    self.navRightBtn = [[UIButton alloc] initWithFrame:(CGRect){KWidth - 54,20,54,44}];
    [self.navRightBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.myNavigationBar addSubview:self.navRightBtn];
    [self changeNavRightBtnTitle:title];
    [self changeNavRightBtnTitleColor:[UIColor whiteColor]];
}


- (void)changeNavRightBtnTitleColor:(UIColor *)color{
    [self.navRightBtn setTitleColor:color forState:UIControlStateNormal];
}

- (void)changeNavRightBtnTitle:(NSString *)title{
    [self.navRightBtn setTitle:title forState:UIControlStateNormal];
}



//设置右按钮图片
- (void)setNavRightBtnImage:(UIImage *)image{
    //右按钮
    self.navRightBtn = [[UIButton alloc] initWithFrame:(CGRect){KWidth - 54,20,54,44}];
    [self.myNavigationBar addSubview:self.navRightBtn];
    [self.navRightBtn setBackgroundImage:image forState:UIControlStateNormal];
}




@end
