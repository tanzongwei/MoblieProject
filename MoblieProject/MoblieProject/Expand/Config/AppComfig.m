//
//  AppComfig.m
//  MoblieProject
//
//  Created by 火豹科技 on 2017/12/27.
//  Copyright © 2017年 火豹科技. All rights reserved.
//

#import "AppComfig.h"

@implementation AppComfig

-(void)comfigApplistion {
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    //初始化设置
    [BaseSetting shareInstance];
}

KSingleToolM(Comfig);

@end
