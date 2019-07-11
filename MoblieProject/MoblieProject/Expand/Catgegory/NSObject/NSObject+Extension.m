//  NSObject+Extension.m
//  YDPCommonProject
//
//  Created by 姚敦鹏 on 2017/5/27.
//  Copyright © 2017年 Encifang. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

/** 判断网络 */
- (YDPNetworkConnectionStatus)connectionInternet
{
    YDPNetworkConnectionStatus netWorkStatus = 0;
    
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reach currentReachabilityStatus];
    switch (status) {
        case NotReachable:
            netWorkStatus = YDPNetworkConnectionStatusNoFund;
            break;
        case ReachableViaWiFi:
            netWorkStatus = YDPNetworkConnectionStatusReachableViaWiFi;
            break;
        case ReachableViaWWAN:
            netWorkStatus = YDPNetworkConnectionStatusReachableViaWWAN;
            break;
        default:
            break;
    }
    return netWorkStatus;
}

- (BOOL)internetConnection
{
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reach currentReachabilityStatus];
    BOOL isConnected;
    switch (status) {
        case NotReachable:
            isConnected = NO;
            break;
        case ReachableViaWiFi:
            isConnected = YES;
            break;
        case ReachableViaWWAN:
            isConnected = YES;
            break;
        default:
            break;
    }
    return isConnected;
}

#pragma mark -- UIAlertView 没有回调，只显示 (一个按钮)
- (void)alert:(NSString *)msg
{
    [self alert:msg cancel:@"确定"];
}
- (void)alert:(NSString *)msg
       cancel:(NSString *)cancel
{
    [self alertTitle:@"温馨提示" message:msg cancel:cancel];
}
- (void)alertTitle:(NSString *)title
           message:(NSString *)msg
            cancel:(NSString *)cancel
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:cancel otherButtonTitles:nil, nil];
    [alert show];
}


#pragma mark -- UIAlertView 没有回调，只显示 (两个按钮)
- (void)alertSure:(NSString *)msg
{
    [self alert:msg sure:@"确定"];
}
- (void)alert:(NSString *)msg
         sure:(NSString *)sure
{
    [self alertTitle:@"温馨提示" message:msg sure:sure];
}
- (void)alertTitle:(NSString *)title
           message:(NSString *)msg
              sure:(NSString *)sure
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:sure, nil];
    [alert show];
}


#pragma mark -- UIAlertView 有回调 (一个按钮)
- (void)alert:(NSString *)msg
       action:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))action
{
    [self alert:msg cancel:@"确定" action:action];
}
- (void)alert:(NSString *)msg
       cancel:(NSString *)cancel
       action:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))action
{
    [self alertTitle:@"温馨提示" message:msg cancel:cancel action:action];
}
- (void)alertTitle:(NSString *)title
           message:(NSString *)msg
            cancel:(NSString *)cancel
            action:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))action
{
    UIAlertView *alert = [UIAlertView bk_showAlertViewWithTitle:title message:msg cancelButtonTitle:cancel otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (action)
        {
            action(alertView,buttonIndex);
        }
    }];
    [alert show];
}


#pragma mark -- UIAlertView 有回调 (两个按钮)
- (void)alert:(NSString *)msg
   sureAction:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))action
{
    [self alert:msg sure:@"确定" sureAction:action];
}
- (void)alert:(NSString *)msg
         sure:(NSString *)sure
   sureAction:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))action
{
    [self alertTitle:@"温馨提示" message:msg sure:sure sureAction:action];
}
- (void)alertTitle:(NSString *)title
           message:(NSString *)msg
              sure:(NSString *)sure
        sureAction:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))action
{
    UIAlertView *alert = [UIAlertView bk_showAlertViewWithTitle:title message:msg cancelButtonTitle:@"取消" otherButtonTitles:@[sure] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (action)
        {
            action(alertView,buttonIndex);
        }
    }];
    [alert show];
}

#pragma mark -- NSDate
/** 时间转为字符串 */
-(NSString *)timestampWith:(NSDate *)date andFormatter:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

/** 将某个时间戳转化成 时间 */
/** 将某个时间戳转化成 时间字符串 */
-(NSString *)dateStrWithtimestamp:(NSInteger)timestamp andFormatter:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}

/** 将某个时间戳转化成 时间 */
-(NSDate *)dateWithtimestamp:(NSInteger)timestamp andFormatter:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    return [NSDate dateWithTimeIntervalSince1970:timestamp];
}

-(NSDate *)dateWithStr:(NSString *)dateStr andFormatter:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    
    [formatter setDateFormat:format];
    
    return [formatter dateFromString:dateStr];
}

-(void)setBottomLine:(NSArray *)viewArray {
    
    for (id view in viewArray) {
        UIView *lineView = getSubViewForm([UIView class], view, 99);
        if (!lineView) {
            
            UIView *subView = (UIView *)view;
            CGRect frame = subView.frame;
            lineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
            lineView.tag = 99;
            lineView.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1];
            [view addSubview:lineView];
        }
        
        lineView.hidden = NO;
    }
}

id getSubViewForm(Class aClass,UIView *View,NSInteger tag)
{
    id obj = nil;
    NSArray *listView = View.subviews;
    for (UIView *v in listView) {
        if ([v isKindOfClass:[aClass class]] && v.tag == tag) {
            obj = v;
            break;
        }
    }
    
    return obj;
}

@end
