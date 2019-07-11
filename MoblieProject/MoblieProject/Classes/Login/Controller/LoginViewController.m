//
//  LoginViewController.m
//  OldMasterGame
//
//  Created by 姚敦鹏 on 2017/12/15.
//  Copyright © 2017年 火豹科技. All rights reserved.
//

#import "LoginViewController.h"
#import "WechatModel.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UIImageView *appIcon;
@property (weak, nonatomic) IBOutlet UIButton *WXLoginButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topConstraint.constant = kStatusAndNavBarH;
    ViewRadius(self.appIcon, HEIGHT(self.appIcon)/2);
    ViewRadius(self.WXLoginButton, HEIGHT(self.WXLoginButton)/2);
}

- (IBAction)LoginAction:(id)sender {
    
    ClassWeak(weakClass);
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {

        if (error) {
            DLog(@"wechat Error == %@",error);
            [YPProgressHUD showErrorHUDWithTitle:@"登录失败"];
            return ;
        }

        UMSocialUserInfoResponse *resp = result;
        [weakClass saveLoginInfo:resp];
        
        [[AppHelper shareInstance] resetRootTabbar];
    }];
}

- (void)saveLoginInfo:(UMSocialUserInfoResponse *)resp {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *address = [NSString stringWithFormat:@"%@%@%@",[resp.originalResponse objectForKey:@"country"],[resp.originalResponse objectForKey:@"city"],[resp.originalResponse objectForKey:@"province"]];
    
    [dic setValue:resp.uid forKey:@"uid"];
    [dic setValue:resp.openid forKey:@"openid"];
    [dic setValue:resp.accessToken forKey:@"accessToken"];
    [dic setValue:resp.name forKey:@"name"];
    [dic setValue:resp.iconurl forKey:@"iconurl"];
    [dic setValue:resp.unionGender forKey:@"unionGender"];
    [dic setValue:address forKey:@"address"];

    //存给AppDelegate
    WechatModel *userInfo = [WechatModel mj_objectWithKeyValues:dic];
    [AppDelegate shareAppDelegate].wechatInfo = userInfo;
    
    NSData *userData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    //个人信息存储
    [kUserDefaults setValue:userData forKey:USER_WECHAT_INFORMATION];
    //登录时间存储
    [kUserDefaults setValue:[self timestampWith:[NSDate date] andFormatter:@"yyyy-MM-dd hh:mm:ss" ] forKey:USER_LOGIN_TIME];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
