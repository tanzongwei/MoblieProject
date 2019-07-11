//
//  YPProgressHUD.h
//  SVPTest
//
//  Created by 火豹科技 on 2017/12/22.
//  Copyright © 2017年 火豹科技. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

@interface YPProgressHUD : SVProgressHUD

#pragma mark -- 小菊花 提示
/** 直接文字HUD 1s移除 */
+(void)showHUDMessage:(NSString *)message;
/** 直接文字HUD 回调 */
+(void)showHUDMessage:(NSString *)message complete:(void(^)(void))complete;
/** HUD 回调 */
+(void)showHUDMessage:(NSString *)message
          dismissTime:(NSTimeInterval)time
             complete:(void(^)(void))complete;

#pragma mark -- 加载中
+(void)showLoading;

#pragma mark -- 加载中DIY...
+ (void)showDIYLoading;

#pragma mark -- 自定义文字...
+ (void)showDIYLoadingMsg:(NSString *)message;

#pragma mark -- 小菊花 网络请求 带activity 或者 图片
/** 显示HUD */
+(void)showHUDWithTitle:(NSString *)title;

/** 成功HUD */
+(void)showSuccessHUDWithTitle:(NSString *)title;
/** 失败HUD */
+(void)showErrorHUDWithTitle:(NSString *)title;
/** 信息HUD */
+(void)showInfoHUDWithTitle:(NSString *)title;

/** 隐藏HUD */
+(void)dismissHUD;
/** 隐藏HUD带时间参数 */
+(void)dismissHUDWithDelay:(NSTimeInterval)delay;

@end
