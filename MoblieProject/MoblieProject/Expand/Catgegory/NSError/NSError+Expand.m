//
//  NSError+Expand.m
//  OldMasterGame
//
//  Created by 火豹科技 on 2017/12/20.
//  Copyright © 2017年 火豹科技. All rights reserved.
//

#import "NSError+Expand.h"

@implementation NSError (Expand)

#pragma mark -- 自定义错误
/**
 自定义错误
 
 @param description 错误描述
 @param code 错误码
 */
+(NSError *)errorWithDescription:(NSString *)description code:(NSInteger)code {
    
    NSString *domain = @"com.Application.ErrorDomain";
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : description };
    
    return [NSError errorWithDomain:domain
                               code:code
                           userInfo:userInfo];
    
}

@end
