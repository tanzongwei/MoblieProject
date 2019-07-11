#import <UIKit/UIKit.h>


#pragma mark -- 账户信息模块

/** 登录微信 信息存储 */
NSString * const USER_WECHAT_INFORMATION = @"USER_WECHAT_INFORMATION";

/** 登录后用户 信息存储 */
NSString * const USER_INFORMATION = @"USER_INFORMATION";

/** 用户登录的时间 （微信授权成功后保存，5天之后再进行登录授权）*/
NSString * const USER_LOGIN_TIME  = @"USER_LOGIN_TIME";

/** 用户登录token */
NSString * const USER_TOKEN       = @"USER_TOKEN";

/** 用户 skey */
NSString * const USER_SKEY       = @"USER_SKEY";

/** 用户选择的 区 */
NSString * const USER_CHOOCE_REGION = @"USER_CHOOCE_REGION";

/** 用户选择的 区 对应的 ID 号 */
NSString * const USER_CHOOCE_REGION_ID = @"USER_CHOOCE_REGION_ID";

/** 进入房间历史记录 */
NSString * const USER_JOINROOM_HISTORY = @"USER_JOINROOM_HISTORY";

#pragma mark --
#pragma mark -- 第三方相关

#pragma mark -- 友盟相关
/** 友盟AppKey */
NSString * const USHARE_DEMO_APPKEY = @"5a387803a40fa353b30000cc";

/** 微信appKey */
NSString * const WechatAppKey       = @"wxdd48b7166246e0a6";
NSString * const WechatAppSecret    = @"7d1faebdfc1d6b63bc7f560de5c9c906";
