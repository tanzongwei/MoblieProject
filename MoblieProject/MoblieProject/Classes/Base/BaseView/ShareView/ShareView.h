//
//  SharePopView.h
//  CloudPurchase
//
//  Created by 姚敦鹏 on 2017/10/12.
//  Copyright © 2017年 Xie泽锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareView : UIView
//@property (nonatomic,strong) NSString *content;


+(id)shareInstallWithMsgObject:(UMSocialMessageObject *)messageObject
                      cutImage:(UIImage *)image
                  refreshBlock:(void(^)(void))refreshBlock
                   resultBlock:(void(^)(id data, NSError *error))resultBlock;

-(void)show;
-(void)hidden;

@end
