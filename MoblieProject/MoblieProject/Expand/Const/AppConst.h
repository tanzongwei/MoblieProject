#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


#pragma mark -- 账户信息模块

/** 登录微信 信息存储 */
UIKIT_EXTERN NSString * const USER_WECHAT_INFORMATION;

/** 登录后用户 信息存储 */
UIKIT_EXTERN NSString * const USER_INFORMATION;

/** 用户登录的时间 （微信授权成功后保存，5天之后再进行登录授权） */
UIKIT_EXTERN NSString * const USER_LOGIN_TIME;

/** 用户 skey */
UIKIT_EXTERN NSString * const USER_SKEY;

/** 用户登录token */
UIKIT_EXTERN NSString * const USER_TOKEN;

/** 用户选择的 区 */
UIKIT_EXTERN NSString * const USER_CHOOCE_REGION;

/** 用户选择的 区 对应的 ID 号 */
UIKIT_EXTERN NSString * const USER_CHOOCE_REGION_ID;

/** 进入房间历史记录 */
UIKIT_EXTERN NSString * const USER_JOINROOM_HISTORY;

#pragma mark --
#pragma mark -- 第三方相关

#pragma mark -- 友盟相关
/** 友盟AppKey */
UIKIT_EXTERN NSString * const USHARE_DEMO_APPKEY;

/** 微信appKey */
UIKIT_EXTERN NSString * const WechatAppKey;
UIKIT_EXTERN NSString * const WechatAppSecret;
