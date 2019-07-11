#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//是否上架app store 1：上架    0：测试环境
#define AppStore  1

#pragma mark -- HOST

/** BaseUrl */
UIKIT_EXTERN NSString * const BaseURL;

/** webView api */
UIKIT_EXTERN NSString * const Fire_WebURL;

/** 获取token 接口 */
UIKIT_EXTERN NSString * const Fire_UserToken_Url;

/** 选择大区列表 */
UIKIT_EXTERN NSString * const Fire_ChooseArea_URL;

/** 注册 URL */
UIKIT_EXTERN NSString * const Fire_register_URL;

/** 登录 URL */
UIKIT_EXTERN NSString * const Fire_Login_URL;



/** 获取游戏房间链接 */
UIKIT_EXTERN NSString * const Fire_GetRoom_URL;
