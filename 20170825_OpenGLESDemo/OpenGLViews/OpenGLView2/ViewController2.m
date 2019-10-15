//
//  ViewController2.m
//  20170825_OpenGLESDemo
//
//  Created by shaoqiu on 2017/8/28.
//  Copyright © 2017年 shaoqiu. All rights reserved.
//

#import "ViewController2.h"
#import "OpenGLView2.h"

@interface ViewController2 ()
@property (nonatomic, strong) OpenGLView2 *glView;
@property (nonatomic, strong) UIView *myView;
@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"OpenGLESDemo";
 
    [self initUI];
}

- (void)initUI{
    self.glView = [[OpenGLView2 alloc] initWithFrame:(CGRect){10,kTopBarSafeHeight + 10,kScreenWidth - 20,kScreenHeight - kTopBarSafeHeight - 20}];
    [self.view addSubview:self.glView];
}

@end
