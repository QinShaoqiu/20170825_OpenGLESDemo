//
//  ViewController.m
//  20170825_OpenGLESDemo
//
//  Created by shaoqiu on 2017/8/25.
//  Copyright © 2017年 shaoqiu. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"
#import "ViewController5.h"
#import "ViewController6.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *optionTableView;
@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavTitleBtnTitle:@"OpenGL"];
    [self initTableView];
}


- (void)initTableView{
    _titleArr = @[@"实心方块 深度测试",
                  @"一片绿色",
                  @"一片彩色",
                  @"小片彩色-投影",
                  @"小片彩色 移动+旋转",
                  @"正方体"];
    
    self.optionTableView = [[UITableView alloc] initWithFrame: CGRectMake(5, NavHight, KWidth - 10, KHeight - NavHight)];
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
            //4
            ViewController5 *vc = [[ViewController5 alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 5:
        {
            //4
            ViewController6 *vc = [[ViewController6 alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

@end
