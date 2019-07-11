//
//  YPRefreshHeader.m
//  SVPTest
//
//  Created by 火豹科技 on 2017/12/22.
//  Copyright © 2017年 火豹科技. All rights reserved.
//

#import "YPRefreshHeader.h"

@implementation YPRefreshHeader

-(void)prepare{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 60; i++) {
        UIImage *image = [UIImage imageNamed:@"refresh_1"];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 7; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
