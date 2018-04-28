//
//  SHSuperViewController.h
//  SmartHome
//
//  Created by qinshaoqiu on 17/6/10.
//  Copyright © 2017年 guet215. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "general.h"

@interface SHSuperViewController : UIViewController
@property (nonatomic, strong) UIView *myNavigationBar;
@property (nonatomic, strong) UIButton *navTitleBtn;//标题
@property (nonatomic, strong) UIButton *navBackBtn;//返回按钮
@property (nonatomic, strong) UIButton *navRightBtn;//右边的按钮

- (void)setNavTitleBtnTitle:(NSString *)title;//设置标题
- (void)setNavTitleBtnImage:(UIImage *)image;//设置标题图片

- (void)setNavBackBtnTitle:(NSString *)title;//设置左按钮标题
- (void)changeNavRightBtnTitleColor:(UIColor *)color;
- (void)changeNavRightBtnTitle:(NSString *)title;
- (void)setNavBackBtnImage:(UIImage *)image;//设置左按钮图片

- (void)setNavRightBtnTitle:(NSString *)title;//设置右按钮标题
- (void)setNavRightBtnImage:(UIImage *)image;//设置右按钮图片


@end
