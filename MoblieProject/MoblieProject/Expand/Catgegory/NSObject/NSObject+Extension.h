//  NSObject+Extension.h
//  YDPCommonProject
//
//  Created by 姚敦鹏 on 2017/5/27.
//  Copyright © 2017年 Encifang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CommonEnum.h"

@interface NSObject (Extension)

/*
 *  @brief 判断网络 状态
 *  @param  YDPNetworkConnectionStatusNoFund, // 没有找到网络
 *  @param  YDPNetworkConnectionStatusUnknown, // 未知网络
 *  @param  YDPNetworkConnectionStatusReachableViaWWAN, // 手机自带网络
 *  @param  YDPNetworkConnectionStatusReachableViaWiFi // WIFI
 */
- (YDPNetworkConnectionStatus)connectionInternet;

/*
 *  @brief 获取是否有网络
 */
- (BOOL)internetConnection;

#pragma mark -- UIAlertView 没有回调 只显示 (一个按钮)
- (void)alert:(NSString *)msg;

- (void)alert:(NSString *)msg
       cancel:(NSString *)cancel;

- (void)alertTitle:(NSString *)title
           message:(NSString *)msg
            cancel:(NSString *)cancel;


#pragma mark -- UIAlertView 没有回调，只显示 (两个按钮)
- (void)alertSure:(NSString *)msg;

- (void)alert:(NSString *)msg
         sure:(NSString *)sure;

- (void)alertTitle:(NSString *)title
           message:(NSString *)msg
              sure:(NSString *)sure;


#pragma mark -- UIAlertView 有回调 只显示 (一个按钮)
- (void)alert:(NSString *)msg
       cancel:(NSString *)cancel
       action:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))action;

- (void)alert:(NSString *)msg
       action:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))action;

- (void)alertTitle:(NSString *)title
           message:(NSString *)msg
            cancel:(NSString *)cancel
            action:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))action;


#pragma mark -- UIAlertView 有回调 (两个按钮)
- (void)alert:(NSString *)msg
   sureAction:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))action;

- (void)alert:(NSString *)msg
         sure:(NSString *)sure
   sureAction:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))action;

- (void)alertTitle:(NSString *)title
           message:(NSString *)msg
              sure:(NSString *)sure
        sureAction:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))action;

#pragma mark -- 时间 NSDate

/** 时间转为字符串 */
-(NSString *)timestampWith:(NSDate *)date
              andFormatter:(NSString *)format;

/** 将某个时间戳转化成 时间字符串 */
-(NSString *)dateStrWithtimestamp:(NSInteger)timestamp
                     andFormatter:(NSString *)format;

/** 将某个时间戳转化成 时间 */
-(NSDate *)dateWithtimestamp:(NSInteger)timestamp
                andFormatter:(NSString *)format;

/** 将某个时间戳转化成 时间 */
-(NSDate *)dateWithStr:(NSString *)dateStr
          andFormatter:(NSString *)format;

#pragma mark -- 下划线
/**
 设置下划线

 @param viewArray view 数组
 */
-(void)setBottomLine:(NSArray *)viewArray;

@end
