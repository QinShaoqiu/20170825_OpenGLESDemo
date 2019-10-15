//
//  ViewController6.m
//  20170825_OpenGLESDemo
//
//  Created by shaoqiu on 2017/8/28.
//  Copyright © 2017年 shaoqiu. All rights reserved.
//

#import "ViewController6.h"
#import "OpenGLView6.h"

@interface ViewController6 ()
@property (nonatomic, strong) OpenGLView6 *glView;
@property (nonatomic, strong) UIView *myView;
@property (nonatomic, strong) UIButton *stopBtn;
@end

@implementation ViewController6

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"OpenGLESDemo";

    [self initUI];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.glView stopDisplayLink];
}

- (void)initUI{
    self.glView = [[OpenGLView6 alloc] initWithFrame:(CGRect){10,kTopBarSafeHeight + 10,kScreenWidth - 20,kScreenHeight - kTopBarSafeHeight - 20 - 100}];
    [self.view addSubview:self.glView];
    self.stopBtn = [[UIButton alloc] initWithFrame:(CGRect){0,kScreenHeight - 20 - 50,kScreenWidth,50}];
    [self.stopBtn setTitle:@"停止" forState:UIControlStateNormal];
    [self.stopBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.stopBtn setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:self.stopBtn];
    
    self.stopBtn.selected = YES;
    [self.stopBtn addTarget:self action:@selector(stopBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)stopBtnClick{
    
    if (self.stopBtn.selected) {
        NSLog(@"停止");
        [self.stopBtn setTitle:@"开始" forState:UIControlStateNormal];
        [self.glView stopDisplayLink];
        self.stopBtn.selected = NO;
        
    }else{
        NSLog(@"启动定时器");
        [self.stopBtn setTitle:@"停止" forState:UIControlStateNormal];
        [self.glView setupDisplayLink];
        self.stopBtn.selected = YES;
    }
}

@end
