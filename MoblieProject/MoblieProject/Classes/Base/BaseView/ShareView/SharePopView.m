//
//  SharePopView.m
//  CloudPurchase
//
//  Created by 姚敦鹏 on 2017/10/12.
//  Copyright © 2017年 Xie泽锋. All rights reserved.
//

#import "SharePopView.h"
#import <UMSocialCore/UMSocialCore.h>

@interface SharePopView ()

@property (weak, nonatomic) IBOutlet UIView *wechat;
@property (weak, nonatomic) IBOutlet UIView *friendCircle;
@property (weak, nonatomic) IBOutlet UIView *QQ;
@property (weak, nonatomic) IBOutlet UIView *refresh;

@end

@implementation SharePopView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [self.wechat addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    [self.friendCircle addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    [self.QQ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    [self.refresh addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    
    if (self.cutImage == nil) {
        self.QQ.hidden      = YES;
        self.refresh.hidden = YES;
    }
}

-(void)tapAction:(UITapGestureRecognizer *)tap {
    NSLog(@"tap.view.tag --> %d",(int)tap.view.tag);
    if (self.CancleBlock) {
        self.CancleBlock(self);
    }
    
    NSInteger tag = tap.view.tag;
    if (tag < 3) {
        UMSocialPlatformType type = tag == 2 ? UMSocialPlatformType_WechatTimeLine : UMSocialPlatformType_WechatSession;
        [self shareWebPageToPlatformType:type];
    } else {
        
        if (tag == 3) {
            if (self.cutImage) {
                [MyPublicClass saveImage:self.cutImage];
            }
        } else {
            self.refreshBlock ? self.refreshBlock() : nil;
        }
    }
}

/**
 分享网页
 */
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    //设置文本
//    messageObject.text = self.descrString;
    
    //调用分享接口
    [self shareToPlatform:platformType messageObject:self.messageObject currentViewController:nil];
}

- (void)shareToPlatform:(UMSocialPlatformType)platformType
          messageObject:(UMSocialMessageObject *)messageObject
  currentViewController:(id)currentViewController
{
    
    __weak typeof(self) weakSelf = self;

    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:currentViewController completion:^(id data, NSError *error) {
        if (error) {
            DLog(@"************Share fail with error %@*********",error);
        }else{
            DLog(@"response data is %@",data);
        }
        
        weakSelf.result ? weakSelf.result(data, error) : nil;
    }];
}

- (IBAction)cancleAction:(id)sender {
    
    DLog(@"分享取消");
    self.CancleBlock ? self.CancleBlock(self) : nil;
}

@end
