//
//  UserModel.h
//  OldMasterGame
//
//  Created by 火豹科技 on 2017/12/20.
//  Copyright © 2017年 火豹科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

/** 用户 ID */
@property (copy, nonatomic) NSString *id;

/** 昵称 */
@property (copy, nonatomic) NSString *nickName;

/** 性别 1：男 2：女 */
@property (assign, nonatomic) NSInteger sex;

/** 城市 */
@property (copy, nonatomic) NSString *citys;

/** 头像 */
@property (copy, nonatomic) NSString *path;

/** 授权码 */
@property (copy, nonatomic) NSString *skey;

@end
