//
//  ViewController4.m
//  20170825_OpenGLESDemo
//
//  Created by shaoqiu on 2017/8/28.
//  Copyright © 2017年 shaoqiu. All rights reserved.
//

#import "ViewController4.h"
#import "OpenGLView4.h"

@interface ViewController4 ()
@property (nonatomic, strong) OpenGLView4 *glView;
@property (nonatomic, strong) UIView *myView;
@end

@implementation ViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"OpenGLESDemo";

    [self initUI];
}

- (void)initUI{
    self.glView = [[OpenGLView4 alloc] initWithFrame:(CGRect){10,kTopBarSafeHeight + 10,kScreenWidth - 20,kScreenHeight - kTopBarSafeHeight - 20}];
    [self.view addSubview:self.glView];
}

@end
