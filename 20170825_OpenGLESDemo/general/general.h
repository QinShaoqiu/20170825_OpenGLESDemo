//
//  general.h
//  20170718_localizationDemo
//
//  Created by shaoqiu on 17/7/18.
//  Copyright © 2017年 shaoqiu. All rights reserved.
//

#ifndef general_h
#define general_h

/********************* 通用宏定义 ************************/
//屏幕尺寸
#define KWidth                 [UIScreen mainScreen].bounds.size.width
#define KHeight                [UIScreen mainScreen].bounds.size.height
#define NavHight                64
#define TabBarHight             49
#define OnePixel     (1. / [UIScreen mainScreen].scale)

//适配iPhone
#define isPhone4                            ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPhone5                            ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPhone6                            ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPhone6p                           ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define KViewPosition(x)       [AceGetScreenWidth getScreenWidth] * (x / 750.f)


//控件坐标
#define ViewWidth(v)        v.frame.size.width
#define ViewHeight(v)       v.frame.size.height
#define ViewX(v)            v.frame.origin.x
#define ViewY(v)            v.frame.origin.y
#define View_BX(view)       (view.frame.origin.x + view.frame.size.width)
#define View_BY(view)       (view.frame.origin.y + view.frame.size.height)
#define Rect(x, y, w, h)    CGRectMake(x, y, w, h)

//颜色
#define RGB(r, g, b)                        [UIColor colorWithRed:(r) / 255.f green:(g) / 255.f blue:(b) / 255.f alpha:1.f]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r /255.0 green:g / 255.0 blue:b / 255.0 alpha:a]

#define UIColorFromRGBHex(rgbValue)         [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBHexA(rgbValue, a)         [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define RandomColor                         [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]


//沙盒目录
#define Documents_path  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject]

#define Caches_path  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject]

#define UserDefaults        [NSUserDefaults standardUserDefaults]




/**
 * 打印,若要屏蔽所有打印，则将下面的1改成0
 */
#if 1
#define NSLog(...) NSLog(__VA_ARGS__)
#define NNMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define NNMethod()
#endif



#endif /* general_h */
