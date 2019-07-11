//
//  CommonEnum.h
//  OldMasterGame
//
//  Created by 姚敦鹏 on 2017/12/15.
//  Copyright © 2017年 火豹科技. All rights reserved.
//

#ifndef CommonEnum_h
#define CommonEnum_h

/** 网络状态 */
typedef NS_OPTIONS(NSUInteger, YDPNetworkConnectionStatus) {
    YDPNetworkConnectionStatusNoFund            = 0,        // 没有找到网络
    YDPNetworkConnectionStatusUnknown           = 1 << 0,   // 未知网络
    YDPNetworkConnectionStatusReachableViaWWAN  = 1 << 1,   // 手机自带网络
    YDPNetworkConnectionStatusReachableViaWiFi  = 1 << 2,   // WIFI
};

#endif /* CommonEnum_h */
