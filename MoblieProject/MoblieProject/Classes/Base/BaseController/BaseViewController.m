//
//  BaseViewController.m
//  OldMasterGame
//
//  Created by 姚敦鹏 on 2017/12/15.
//  Copyright © 2017年 火豹科技. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
<UIGestureRecognizerDelegate>
{
    /** 返回按钮 */
    UIBarButtonItem * backItem;
}
@end

#define ItemBgColor [UIColor clearColor]
#define ItemColor   [UIColor blackColor]
#define ItemFont    [UIFont systemFontOfSize:14]

static UIColor *otherNavColor;

@implementation BaseViewController

-(WechatModel *)wechatInfo {
    
    return [AppDelegate shareAppDelegate].wechatInfo;
}

-(UserModel *)userInfo {
    
    return [AppDelegate shareAppDelegate].userInfo;
}

-(void)setNavBarAllColor:(UIColor *)navBarAllColor {
    
    BaseNavigationViewController * nav = (BaseNavigationViewController*)self.navigationController;
    nav.navBarColor =  _navBarAllColor = navBarAllColor;
    self.navigationController.navigationBar.barTintColor = navBarAllColor;
}

-(void)initBackButton {
    
    [self.navigationItem setHidesBackButton:YES];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 返回按钮内容左靠
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    backBtn.frame = CGRectMake(0, 0, 50, 18);
    [backBtn setTitle:@"返回" forState:0];
    backBtn.titleLabel.font = kSFont(14);
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 0);
    backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
    [backBtn setImage:[UIImage imageNamed:[BaseSetting shareInstance].backImage] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    backItem.title = @"返回";
    self.navigationItem.leftBarButtonItem = backItem;
    
    _backButton = backBtn;
}

-(void)setClearNavColor:(BOOL)clearNavColor {
    
    _clearNavColor = clearNavColor;
    if (_clearNavColor) {
        self.nowNavBarColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"clear"]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;
    
    self.view.backgroundColor = [BaseSetting shareInstance].viewBackColor;

    self.automaticallyAdjustsScrollViewInsets = YES;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    [self initBackButton];
    
    if (self.backButton) {
        
        if (self.navigationController.viewControllers.count != 1) {
            
            [self.navigationItem setHidesBackButton:YES];
            self.navigationItem.leftBarButtonItem = backItem;
            
            [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                                 forBarMetrics:UIBarMetricsDefault];
            
        } else {
            
            self.navigationItem.leftBarButtonItem = nil;
        }
    }
    if (!self.nowNavBarColor &&
        [BaseSetting shareInstance].navColor) {
        
        self.navigationController.navigationBar.barTintColor = [BaseSetting shareInstance].navColor;
    }
    
    BaseNavigationViewController *nav = (BaseNavigationViewController *)self.navigationController;
    if (nav.navBarColor) {
        self.navigationController.navigationBar.barTintColor = nav.navBarColor;
    }
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[BaseSetting shareInstance].titleColor,NSFontAttributeName:[BaseSetting shareInstance].titleFont};
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;

    if (_hideCurrentNavBar)//是否隐藏导航
    {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
    if (_nowNavBarColor) {
        self.navigationController.navigationBar.barTintColor = _nowNavBarColor;
    }
    
    BaseNavigationViewController *nav = (BaseNavigationViewController *)self.navigationController;
    if (nav.navBarColor) {
        self.navigationController.navigationBar.barTintColor = nav.navBarColor;
    }
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[BaseSetting shareInstance].titleColor,NSFontAttributeName:[BaseSetting shareInstance].titleFont};
    
    [self.navigationController.navigationBar setShadowImage:[MyPublicClass imgColor:[UIColor clearColor]]];
    
    if (isIOS(10)) {
        self.tabBarController.tabBar.subviews[0].subviews[1].hidden = YES;
    } else {
        [self.tabBarController.tabBar setShadowImage:[MyPublicClass imgColor:[UIColor clearColor]]];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (_hideCurrentNavBar) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
    
    if (otherNavColor) {
        self.navigationController.navigationBar.barTintColor = otherNavColor;
    }
}


#pragma mark -- Public
- (UIBarButtonItem *)addRightButton:(NSString *)title
             textColor:(UIColor *)titleColor
             titleFont:(UIFont *)titleFont
               bgColor:(UIColor *)bgColor
                 image:(UIImage *)image
                action:(SEL)action {
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 2, 40, 40)];
    
    button.backgroundColor = bgColor ? bgColor : ItemBgColor;

    if (title != nil && title.length > 0) {
        
        [button setTitle:title forState:(UIControlStateNormal)];
        button.titleLabel.font = titleFont ? titleFont : ItemFont;
        [button setTitleColor:titleColor ? titleColor : ItemColor forState:0];
        
        CGFloat titleWidth = [self widthWithFont:button.titleLabel.font constrainedToHeight:button.frame.size.height content:title] + 10;
        titleWidth = titleWidth > 40 ? titleWidth : 40;
        
        CGRect frame = button.frame;
        button.frame = CGRectMake(frame.origin.x, frame.origin.y, titleWidth, frame.size.height);
    }
    
    if (image != nil) {
        
        [button setImage:image forState:(UIControlStateNormal)];
        button.imageView.contentMode = UIViewContentModeCenter;
    }
    
    [button addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (void)setStatusBarBg {
    
    UIView *statusBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kStatusBarH)];
    statusBg.backgroundColor = [BaseSetting shareInstance].navColor;
    [self.view addSubview:statusBg];
}

- (CGFloat)widthWithFont:(UIFont *)font
     constrainedToHeight:(CGFloat)height
                 content:(NSString *)content
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [content boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                         options:(NSStringDrawingUsesLineFragmentOrigin |
                                                  NSStringDrawingTruncatesLastVisibleLine)
                                      attributes:attributes
                                         context:nil].size;
    } else {
        textSize = [content sizeWithFont:textFont
                       constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)
                           lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [content boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                     options:(NSStringDrawingUsesLineFragmentOrigin |
                                              NSStringDrawingTruncatesLastVisibleLine)
                                  attributes:attributes
                                     context:nil].size;
#endif
    
    return ceil(textSize.width);
}

- (NSString *)getWebViewHostStr {
    
    NSString *host = [NSString stringWithFormat:@"http://%@%@/",@"%@",Fire_WebURL];
    
    //根据 区的ID 获取 host
    NSString *region_id = [kUserDefaults valueForKey:USER_CHOOCE_REGION_ID];
    if (region_id.integerValue == 11) {
        host = [NSString stringWithFormat:host,@"shouquandating"];
    } else if (region_id.integerValue == 12) {
        host = [NSString stringWithFormat:host,@"dashengzhongyu"];
    } else if (region_id.integerValue == 13) {
        host = [NSString stringWithFormat:host,@"liuliuxianyue"];
    } else if (region_id.integerValue == 14) {
        host = [NSString stringWithFormat:host,@"lianyundating"];
    } else {
        [YPProgressHUD showErrorHUDWithTitle:@"当前平台尚未开放"];
        return nil;
    }
    
    return host;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
