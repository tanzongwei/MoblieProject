#import <UIKit/UIKit.h>

#pragma mark -- HOST


#pragma mark -- 正式环境
#if AppStore

/** BaseUrl */
NSString * const BaseURL                = @"api.lfzgame.com";

/** webView api */
NSString * const Fire_WebURL            = @".154ekh.cn";

/** 获取token 接口 */
NSString * const Fire_UserToken_Url     = @"https://%@api.lfzgame.com";

/** 选择大区列表 */
NSString * const Fire_ChooseArea_URL    = @"http://www.lfzgames.com/index/wechats.html";

/** 注册 URL */
NSString * const Fire_register_URL      = @"/Home/Wechat/register.html";

/** 登录 URL */
NSString * const Fire_Login_URL         = @"/Home/Wechat/login.html";

/** 获取游戏房间链接 */
NSString * const Fire_GetRoom_URL       = @"/Home/User/getRoom.html";

#pragma mark -- 测试环境
#else

/** BaseUrl */
NSString * const BaseURL                = @"api.468k.cn";

/** 获取token 接口 */
NSString * const Fire_UserToken_Url     = @"http://%@api.468k.cn";

/** 选择大区列表 */
NSString * const Fire_ChooseArea_URL    = @"http://www.lfzgames.com/index/wechats.html";

/** 注册 URL */
NSString * const Fire_register_URL      = @"/Home/Wechat/register.html";

/** 登录 URL */
NSString * const Fire_Login_URL         = @"/Home/Wechat/login.html";

/** 获取游戏房间链接 */
NSString * const Fire_GetRoom_URL       = @"/Home/User/getRoom.html";

#endif

