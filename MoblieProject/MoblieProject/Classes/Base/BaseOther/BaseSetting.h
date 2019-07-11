//
//  BaseSetting.h
//  OldMasterGame
//
//  Created by 姚敦鹏 on 2017/12/14.
//  Copyright © 2017年 火豹科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseSetting : NSObject

#pragma mark -- 导航栏
/** 全局导航栏颜色 */
@property(nonatomic,strong) UIColor *navColor;

/** 导航栏背景图片 */
@property (strong, nonatomic) UIImage *navImage;

/** 控制器背景颜色 */
@property(nonatomic,strong) UIColor *viewBackColor;

/** 返回按钮图片 */
@property(nonatomic,copy)   NSString *backImage;

/** title字体颜色 */
@property(nonatomic,strong) UIColor *titleColor;

/** title字体 大小 */
@property(nonatomic,strong) UIFont *titleFont;


#pragma mark -- 底部菜单栏

/** tabbar 背景图片 */
@property (strong, nonatomic) UIImage *tabbarImage;

/** tabbar 未选中颜色 */
@property(nonatomic,strong) UIColor *tabbarBgColor;

/** tabbar 未选中颜色 */
@property(nonatomic,strong) UIColor *tabbarItemNormalColor;

/** tabbar 选择颜色 */
@property(nonatomic,strong) UIColor *tabbarItemSelectColor;

/** 实例化唯一对象 */
+ (instancetype)shareInstance;

@end
