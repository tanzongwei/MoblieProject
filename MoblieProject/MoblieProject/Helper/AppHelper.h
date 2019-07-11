//
//  AppHelper.h
//  MoblieProject
//
//  Created by 火豹科技 on 2017/12/27.
//  Copyright © 2017年 火豹科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppHelper : NSObject

+(id)shareInstance;

#pragma mark -- 进入界面模块
/** 首次登陆判断 */
-(void)judgeAutoLogin;





#pragma mark -- 登录模块
/**
 登录
 @param complete 登录信息
 */
- (void)loginResult:(void(^)(id data,NSError *error))complete;

/** 退出登录操作 */
- (void)outLogin;


#pragma mark -- 公共模块

/** 去到登陆界面 */
-(void)resetLoginController;

/** 去到根目录 */
-(void)resetRootTabbar;

/** 获取游戏名称 */
-(NSString *)getGameRootTitle;

/** 置空 NSUserDefault 保存的信息 */
-(void)resetEmptyUserDefault;


@end
