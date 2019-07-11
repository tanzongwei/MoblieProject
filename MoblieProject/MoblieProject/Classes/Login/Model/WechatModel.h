//
//  UserModel.h
//  OldMasterGame
//
//  Created by 姚敦鹏 on 2017/12/15.
//  Copyright © 2017年 火豹科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WechatModel : NSObject

@property (nonatomic,copy) NSString *uid;
@property (nonatomic,copy) NSString *openid;
@property (nonatomic,copy) NSString *accessToken;

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *iconurl;
@property (nonatomic,copy) NSString *unionGender;
@property (nonatomic,copy) NSString *address;

@end
