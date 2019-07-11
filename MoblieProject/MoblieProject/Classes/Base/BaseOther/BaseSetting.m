//
//  BaseSetting.m
//  OldMasterGame
//
//  Created by 姚敦鹏 on 2017/12/14.
//  Copyright © 2017年 火豹科技. All rights reserved.
//

#import "BaseSetting.h"

#define view_bg_Color       [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1]
#define nav_bg_Color        [MyPublicClass colorWithHexString:@"#23164E"]
#define bar_bglColor        [MyPublicClass colorWithHexString:@"#23164E"]
//[UIColor whiteColor]
#define barItem_normalColor [UIColor lightGrayColor]
//[UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1]
#define barItem_selectColor [UIColor colorWithRed:115/255.f green:210/255.f blue:50/255.f alpha:1]

@implementation BaseSetting

static BaseSetting *instance;

+(instancetype)shareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[BaseSetting alloc]init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        self.navColor       = nav_bg_Color;
        self.viewBackColor  = view_bg_Color;
        self.backImage      = @"nav_back";
        self.titleColor     = [UIColor whiteColor];
        self.titleFont      = [UIFont boldSystemFontOfSize:18];
        
        self.tabbarBgColor         = bar_bglColor;
        self.tabbarItemNormalColor = barItem_normalColor;
        self.tabbarItemSelectColor = barItem_selectColor;
    }
    return self;
}

-(UIColor *)navColor{
    if (!_navColor) {
       return  [UIColor whiteColor];
    }
    return _navColor;
}

-(UIColor *)viewBackColor{
    if (!_viewBackColor) {
        return [UIColor whiteColor];
    }
    return _viewBackColor;
}

@end
