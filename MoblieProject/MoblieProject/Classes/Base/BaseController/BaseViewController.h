//
//  BaseViewController.h
//  OldMasterGame
//
//  Created by 姚敦鹏 on 2017/12/15.
//  Copyright © 2017年 火豹科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WechatModel.h"
#import "UserModel.h"

@interface BaseViewController : UIViewController

/** 微信信息 */
@property (strong, nonatomic) WechatModel *wechatInfo;

/** 用户信息 */
@property (strong, nonatomic) UserModel *userInfo;

@property (nonatomic,strong) UIColor *navBarColor;

/** 当前控制器导航栏颜色 */
@property (nonatomic,strong) UIColor *nowNavBarColor;

/** 返回按钮 */
@property (nonatomic,strong) UIButton *backButton;

/** navigationBar 标题颜色 */
@property(nonatomic,strong)  UIColor *navBarAllColor;

/** 隐藏当前控制器导航条 */
@property(nonatomic,assign)BOOL hideCurrentNavBar;

/** 透明色 */
@property(nonatomic,assign)BOOL clearNavColor;

/**
 右侧按钮

 @param title 标题
 @param titleColor 标题颜色
 @param bgColor 按钮背景色
 @param image 图片
 @param action 点击操作
 */
- (UIBarButtonItem *)addRightButton:(NSString *)title
             textColor:(UIColor *)titleColor
             titleFont:(UIFont *)titleFont
               bgColor:(UIColor *)bgColor
                 image:(UIImage *)image
                action:(SEL)action;


/**
 返回事件
 */
- (void)backAction;

/** 获取webView baseApi */
- (NSString *)getWebViewHostStr;

/** 设置状态栏颜色 */
- (void) setStatusBarBg;

@end
