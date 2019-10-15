//
//  GPUImageCollectionViewCell.m
//  20170825_OpenGLESDemo
//
//  Created by qinshaoqing on 2019/10/13.
//  Copyright © 2019 shaoqiu. All rights reserved.
//

#import "GPUImageCollectionViewCell.h"

@implementation GPUImageCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width - 30) / 3, ([UIScreen mainScreen].bounds.size.width - 30) / 3)];
        [self addSubview:self.imgView];
        //self.imgView.image = [UIImage imageNamed:@"icloud"];
    }
    return self;
}

@end
