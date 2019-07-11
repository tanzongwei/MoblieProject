//
//  SharePopView.h
//  CloudPurchase
//
//  Created by 姚敦鹏 on 2017/10/12.
//  Copyright © 2017年 Xie泽锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SharePopView : UIView

/** 分享的文字 */
//@property (nonatomic,strong) NSString *descrString;

/** 截取的图片 */
@property (strong, nonatomic) UIImage *cutImage;

/** 分享的信息 */
@property (strong, nonatomic) UMSocialMessageObject *messageObject;

/** 刷新操作 */
@property (copy, nonatomic) void(^refreshBlock)(void);

/** 结果block */
@property (copy, nonatomic) void(^result)(id data, NSError *error);

/** 取消 */
@property (nonatomic,copy) void(^CancleBlock)(SharePopView *pop);

@end
