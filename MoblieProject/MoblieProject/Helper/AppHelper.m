//
//  AppHelper.m
//  MoblieProject
//
//  Created by 火豹科技 on 2017/12/27.
//  Copyright © 2017年 火豹科技. All rights reserved.
//

#import "AppHelper.h"
#import "LoginViewController.h"

static AppHelper *_instance;

@implementation AppHelper

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+(id)shareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[AppHelper alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

#pragma mark -- 进入界面模块
#pragma mark -- 进入界面判断
-(void)judgeAutoLogin {
    
//    if ([self judgeLogin]) { //需要去登录
//        [self resetLoginController];
//    } else { //跳转首页
        [self resetRootTabbar];
//    }
}

-(void)resetLoginController {
    
    AppDelegate *app = [AppDelegate shareAppDelegate];
    app.window.rootViewController = [[LoginViewController alloc] init];
}

-(void)resetRootTabbar {
    
    [BaseSetting shareInstance];
    AppDelegate *app = [AppDelegate shareAppDelegate];

    BaseTabbarViewController *tabar = [[BaseTabbarViewController alloc] init];
    app.window.rootViewController = tabar;
}

/** 判断是否需要去授权登录 （登录后 5天内不用） */
-(BOOL)judgeLogin {
    
    NSDictionary *data = [kUserDefaults valueForKey:USER_SKEY];
    NSString *dateStr = [kUserDefaults valueForKey:USER_LOGIN_TIME];

    if (data == nil) {
        return YES;
    }

    if (strIsEmpty(dateStr)) {

        [self resetEmptyUserDefault];
        return YES;
    } else {
        NSDate *lastDate = [self dateWithStr:dateStr andFormatter:@"yyyy-MM-dd hh:mm:ss"];
        if ([self dateTimeDifferenceWithStartTime:lastDate] >= 5) {

            [self resetEmptyUserDefault];
            return YES;
        }
    }
    return NO;
}

/** 置空 NSUserDefault 保存的信息 */
-(void)resetEmptyUserDefault {
    
    //用户选择的区的信息
    [kUserDefaults setValue:nil forKey:USER_CHOOCE_REGION];
    //用户 注册后的 信息
    [kUserDefaults setValue:nil forKey:USER_SKEY];
    //选择的区id
    [kUserDefaults setValue:nil forKey:USER_CHOOCE_REGION_ID];
    //用户信息
    [kUserDefaults setValue:nil forKey:USER_TOKEN];
    //用户微信信息
    [kUserDefaults setValue:nil forKey:USER_WECHAT_INFORMATION];
    //登录时间
    [kUserDefaults setValue:nil forKey:USER_LOGIN_TIME];
}

//计算当前时间与生成时间的时间差，转化成分钟
-(NSInteger)dateTimeDifferenceWithStartTime:(NSDate *)startDate
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *nowstr = [formatter stringFromDate:now];
    NSDate *nowDate = [formatter dateFromString:nowstr];
    
    NSTimeInterval start = [startDate timeIntervalSince1970]*1;
    NSTimeInterval end = [nowDate timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    
    int day = (int)value / (24 * 3600);
    
    return day;
}

#pragma mark -- 登录注册模块
/**
 登录
 
 @param complete 登录信息
 */
- (void)loginResult:(void(^)(id data,NSError *error))complete {
    
//    NSString *pingTai = [self getHostStr];
//    NSString *url = [NSString stringWithFormat:Fire_UserToken_Url,pingTai];
//
//    ClassWeak(weakClass);
//    [[YDPAFNetworkTool shareAFNTool] getDataWithUrl:url success:^(id json) {
//
//        [kUserDefaults setValue:json[@"token"] forKey:USER_TOKEN];
//        [weakClass resiter:complete];
//    } fail:^(NSError *error) {
//        complete ? complete(nil, error) : nil;
//    }];
}

-(void)resiter:(void(^)(id data,NSError *error))complete {
    
    // 登录后的 skey
    //    NSDictionary *userDic = [kUserDefaults valueForKey:USER_SKEY];
    //    if (userDic) {
    //        [self login:userDic result:complete];
    //        return;
    //    }
//
//    WechatModel *userInfo = [AppDelegate shareAppDelegate].wechatInfo;
//    NSDictionary *dic = @{@"access_token":userInfo.accessToken,
//                          @"openid":userInfo.openid
//                          };
//
//    ClassWeak(weakClass);
//    [[YDPAFNetworkTool shareAFNTool] postDataWithUrl:Fire_register_URL parameters:dic success:^(id responseObject) {
//        DLog(@"json == %@",responseObject);
//        if ([[responseObject objectForKey:@"status"] integerValue] == 1) {
//
//            [weakClass login:[responseObject objectForKey:@"info"] result:complete];
//            //登录成功，保存Skey
//            [kUserDefaults setValue:[responseObject objectForKey:@"info"] forKey:USER_SKEY];
//        } else {
//            NSError *error = [NSError errorWithDescription:[responseObject objectForKey:@"info"] code:-1011];
//            complete ? complete(nil, error) : nil;
//        }
//    } fail:^(NSError *error) {
//        DLog(@"error --> %@",error);
//        complete ? complete(nil, error) : nil;
//    }];
}

-(void)login:(NSDictionary *)info result:(void(^)(id data,NSError *error))complete {
    
//    NSDictionary *dic = @{@"skey":info[@"skey"],
//                          @"id":info[@"id"]
//                          };
//
//    [[YDPAFNetworkTool shareAFNTool] postDataWithUrl:Fire_Login_URL parameters:dic success:^(id responseObject) {
//        DLog(@"json == %@",responseObject);
//        if ([[responseObject objectForKey:@"status"] integerValue] == 1) {
//
//            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//            [dict addEntriesFromDictionary:responseObject[@"info"][@"info"]];
//            [dict setValue:responseObject[@"info"][@"skey"] forKey:@"skey"];
//
//            //信息保存
//            NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:(NSJSONWritingPrettyPrinted) error:nil];
//            [kUserDefaults setValue:data forKey:USER_INFORMATION];
//            [AppDelegate shareAppDelegate].userInfo = [UserModel mj_objectWithKeyValues:dict];
//
//            complete ? complete(dict, nil) : nil;
//        } else {
//            NSError *error = [NSError errorWithDescription:[responseObject objectForKey:@"info"] code:-1011];
//            complete ? complete(nil, error) : nil;
//        }
//    } fail:^(NSError *error) {
//        DLog(@"error --> %@",error);
//        complete ? complete(nil, error) : nil;
//    }];
}

- (NSString *)getHostStr {
    
//    NSString *region_id = [kUserDefaults valueForKey:USER_CHOOCE_REGION_ID];
//    if (region_id.integerValue == 11) {
//        return @"shouquandating";
//    } else if (region_id.integerValue == 12) {
//        return @"dashengzhongyu";
//    } else if (region_id.integerValue == 13) {
//        return @"liuliuxianyue";
//    } else if (region_id.integerValue == 14) {
//        return @"lianyundating";
//    } else {
//        [YPProgressHUD showErrorHUDWithTitle:@"当前平台尚未开放"];
        return nil;
//    }
}

/** 退出登录操作 */
- (void)outLogin {
    
    [[AppHelper shareInstance] resetEmptyUserDefault];
    [[AppHelper shareInstance] resetLoginController];
}


#pragma mark -- 公共模块
#pragma mark -- 游戏大厅名称
- (NSString *)getGameRootTitle {
    
//    NSString *region_id = [kUserDefaults valueForKey:USER_CHOOCE_REGION_ID];
//    if (region_id.integerValue == 11) {
//        return @"授权大厅";
//    } else if (region_id.integerValue == 12) {
//        return @"大圣众娱";
//    } else if (region_id.integerValue == 13) {
//        return @"六六闲约";
//    } else if (region_id.integerValue == 14) {
//        return @"联运大厅";
//    } else {
        return @"游戏大厅";
//    }
}

@end
