//
//  YPProgressHUD.m
//  SVPTest
//
//  Created by 火豹科技 on 2017/12/22.
//  Copyright © 2017年 火豹科技. All rights reserved.
//

#import "YPProgressHUD.h"

@implementation YPProgressHUD

#pragma mark -- 菊花

/** HUD 1.5s 移除 */
+(void)showHUDMessage:(NSString *)message
{
    [SVProgressHUD showWithStatus:message];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD dismissWithDelay:1.5];
}

/** HUD 回调 */
+ (void)showHUDMessage:(NSString *)message complete:(void(^)(void))complete
{
    [SVProgressHUD showWithStatus:message];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD dismissWithDelay:1.5 completion:^{
        if (complete) {
            complete();
        }
    }];
}

/** HUD 回调 */
+ (void)showHUDMessage:(NSString *)message
           dismissTime:(NSTimeInterval)time
              complete:(void(^)(void))complete
{
    [SVProgressHUD showWithStatus:message];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD dismissWithDelay:time completion:^{
        if (complete) {
            complete();
        }
    }];
}

#pragma mark -- 加载中...
+ (void)showLoading {
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
}

#pragma mark -- 加载中...
+ (void)showDIYLoading {
    
    [SVProgressHUD setMinimumDismissTimeInterval:MAXFLOAT];
    // 设置背景颜色为透明色
    [SVProgressHUD showImage:[self loadGifImage] status:@"加载中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
}

#pragma mark -- 自定义文字...
+ (void)showDIYLoadingMsg:(NSString *)message {
    
    [SVProgressHUD setMinimumDismissTimeInterval:MAXFLOAT];
    // 设置背景颜色为透明色
    [SVProgressHUD showImage:[self loadGifImage] status:message];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
}

#pragma mark -- 文字
/** 显示HUD */
+ (void)showHUDWithTitle:(NSString *)title
{
    [SVProgressHUD showWithStatus:title];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
}

#pragma mark -- 成功、失败、信息 HUD
/** 成功HUD */
+ (void)showSuccessHUDWithTitle:(NSString *)title
{
    [SVProgressHUD setImageViewSize:CGSizeMake(40, 40)];
    [SVProgressHUD setSuccessImage:[UIImage imageNamed:@"hud_success"]];
    [SVProgressHUD showSuccessWithStatus:title];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [self dismissHUDWithDelay:1.5];
}
/** 失败HUD */
+ (void)showErrorHUDWithTitle:(NSString *)title
{
    [SVProgressHUD setImageViewSize:CGSizeMake(40, 40)];
    [SVProgressHUD setErrorImage:[UIImage imageNamed:@"hud_error"]];
    [SVProgressHUD showErrorWithStatus:title];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [self dismissHUDWithDelay:1.5];
}
/** 信息HUD */
+ (void)showInfoHUDWithTitle:(NSString *)title
{
    [SVProgressHUD setImageViewSize:CGSizeMake(40, 40)];
    [SVProgressHUD setInfoImage:[UIImage imageNamed:@"hud_info"]];
    [SVProgressHUD showInfoWithStatus:title];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [self dismissHUDWithDelay:1.5];
}

+(UIImage *)loadGifImage {
    
    [SVProgressHUD setImageViewSize:CGSizeMake(80, 60)];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *loadingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 9; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_hud_%zd", i]];
        [loadingImages addObject:image];
    }
    
    return [UIImage animatedImageWithImages:loadingImages duration:1.5];
}
#pragma mark -- 隐藏
/** 隐藏HUD */
+ (void)dismissHUD
{
    [SVProgressHUD dismiss];
}

/** 隐藏HUD带时间参数 */
+ (void)dismissHUDWithDelay:(NSTimeInterval)delay
{
    [SVProgressHUD dismissWithDelay:delay];
}

@end
