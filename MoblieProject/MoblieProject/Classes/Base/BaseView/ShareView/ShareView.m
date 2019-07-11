//
//  SharePopView.m
//  CloudPurchase
//
//  Created by 姚敦鹏 on 2017/10/12.
//  Copyright © 2017年 Xie泽锋. All rights reserved.
//

#import "ShareView.h"
#import "SharePopView.h"

@interface ShareView ()

@property (nonatomic,strong) SharePopView *popView;

@end

@implementation ShareView

- (instancetype)initWithFrame:(CGRect)frame
                    withMsgObject:(UMSocialMessageObject *)messageObject
                     cutImage:(UIImage *)image
                 refreshBlock:(void(^)(void))refreshBlock
                  resultBlock:(void(^)(id data, NSError *error))resultBlock
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.hidden = YES;
        
        _popView                = [SharePopView viewFromXIB];
        _popView.tag            = 100;
        _popView.frame          = CGRectMake(15, kScreenHeight+30, kScreenWidth-30, 150);
        _popView.messageObject  = messageObject;
        _popView.cutImage       = image;
        _popView.refreshBlock   = refreshBlock;
        _popView.result         = resultBlock;
        
        ViewRadius(_popView, 5);
        
        ClassWeak(weakClass);
        _popView.CancleBlock = ^(SharePopView *pop) {
            [weakClass hidden];
        };
        [self addSubview:_popView];
    }
    return self;
}

-(void)show {

    self.hidden = NO;
    ClassWeak(weakClass);
    [UIView animateWithDuration:0.25 animations:^{
        [weakClass.popView setY:kScreenHeight-kHomeLineH-20-150];
    }];
}

-(void)hidden {
    
    self.hidden = YES;
    ClassWeak(weakClass);
    [UIView animateWithDuration:0.25 animations:^{
        [weakClass.popView setY:kScreenHeight+30];
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = touches.anyObject;
    CGPoint touchPos = [touch locationInView:self];
    if(!CGRectContainsPoint(self.popView.frame, touchPos))
    {//判断点击的坐标不在 popView 上面
        [self hidden];
    }
}

+(id)shareInstallWithMsgObject:(UMSocialMessageObject *)messageObject
                      cutImage:(UIImage *)image
                  refreshBlock:(void(^)(void))refreshBlock
                   resultBlock:(void(^)(id data, NSError *error))resultBlock
{
    ShareView *share = [[ShareView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) withMsgObject:messageObject cutImage:image refreshBlock:refreshBlock resultBlock:resultBlock];
    [kKeyWindow addSubview:share];
    return share;
}

@end
