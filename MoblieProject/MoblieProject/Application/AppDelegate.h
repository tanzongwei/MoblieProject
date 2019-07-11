//
//  AppDelegate.h
//  MoblieProject
//
//  Created by 火豹科技 on 2017/12/27.
//  Copyright © 2017年 火豹科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WechatModel;
@class UserModel;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/** 微信信息 */
@property (strong, nonatomic) WechatModel *wechatInfo;

/** 用户信息 */
@property (strong, nonatomic) UserModel *userInfo;

+(AppDelegate *)shareAppDelegate;

@end

