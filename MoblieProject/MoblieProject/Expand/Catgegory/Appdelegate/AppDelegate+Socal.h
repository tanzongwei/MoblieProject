//
//  AppDelegate+Socal.h
//  OldMasterGame
//
//  Created by 姚敦鹏 on 2017/12/15.
//  Copyright © 2017年 火豹科技. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (Socal)
<WXApiDelegate,UMSocialPlatformProvider>

/**
 初始化友盟分享
 */
-(void)initSocal;

@end
