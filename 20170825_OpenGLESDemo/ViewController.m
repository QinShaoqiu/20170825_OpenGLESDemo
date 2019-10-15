//
//  ViewController.m
//  20170825_OpenGLESDemo
//
//  Created by shaoqiu on 2017/8/25.
//  Copyright © 2017年 shaoqiu. All rights reserved.
//

/**
 OpenGL坐标系不同于UIKit坐标系
 UIKit坐标系
  0,0 ---------
    |         |
    |         |
    |------- |(w,h)
 
 OpenGL
     ---------(1,1)
     |         |
     |         |
(-1,-1) |------- |
 
 还有一点需要注意，默认情况各个方向坐标值范围为（-1，1) 而不是UIKit中的（0，w)（0，h)
 在ES1中，可以通过以下代码将坐标系转化为熟悉的（320，480）
 
 - (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
     glViewport(0, 0, rect.size.width * 2, rect.size.height * 2);
     glMatrixMode(GL_PROJECTION);
     glLoadIdentity();
     glOrthof(0, 320, 0, 480, -1024, 1024);
     glMatrixMode(GL_MODELVIEW);
     glLoadIdentity();
 }
 
 */

#import "ViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"
#import "ViewController5.h"
#import "ViewController6.h"
#import "GPUImageViewController.h"
#import "GPUCameraViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *optionTableView;
@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"OpenGL";
    [self initTableView];
}


- (void)initTableView{
    _titleArr = @[@"实心方块 深度测试",
                  @"一片绿色",
                  @"一片彩色",
                  @"小片彩色-投影",
                  @"小片彩色 移动+旋转",
                  @"正方体",
                  @"GPUImage photo",
                  @"GPUImage camera"];
    
    self.optionTableView = [[UITableView alloc] initWithFrame: CGRectMake(5, kTopBarSafeHeight, kScreenWidth - 10, kScreenHeight - kTopBarSafeHeight)];
    [self.optionTableView setBackgroundColor:[UIColor whiteColor]];
    self.optionTableView.delegate = self;
    self.optionTableView.dataSource = self;
    self.optionTableView.rowHeight = 60;
    [self.view addSubview:self.optionTableView];
    //self.optionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.optionTableView.tableFooterView = [[UIView alloc] init];
    
    if (@available(iOS 11.0, *)) {
        self.optionTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark - tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}


#pragma mark - tableView DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *mainCellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainCellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//不显示选中状态
    [cell setBackgroundColor:[UIColor whiteColor]];
    [cell.textLabel setText:self.titleArr[indexPath.row]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:16]];
    [cell.textLabel setTextColor:[UIColor blackColor]];
    
    return cell;
}


#pragma mark -点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            //1
            ViewController1 *vc = [[ViewController1 alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 1:
        {
            //2
            ViewController2 *vc = [[ViewController2 alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 2:
        {
            //3
            ViewController3 *vc = [[ViewController3 alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 3:
        {
            //4
            ViewController4 *vc = [[ViewController4 alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;

        case 4:
        {
            //5
            ViewController5 *vc = [[ViewController5 alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 5:
        {
            //6
            ViewController6 *vc = [[ViewController6 alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
            case 6:
            {
                //7
                GPUImageViewController *vc = [[GPUImageViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            
            case 7:
            {
                GPUCameraViewController *vc = [[GPUCameraViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            
        default:
            break;
    }
}

@end

