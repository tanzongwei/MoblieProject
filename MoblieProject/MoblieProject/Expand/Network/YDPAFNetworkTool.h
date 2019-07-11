//  YDPAFNetworkTool.h
//  YDPCommonProject
//
//  Created by 姚敦鹏 on 2017/5/27.
//  Copyright © 2017年 Encifang. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "YDPDataCacheTool.h"

@interface YDPAFNetworkTool : NSObject

/** GET方法 */
- (void)getDataWithUrl:(NSString *)urlStr success:(void (^)(id json))success fail:(void (^)(NSError *error))fail;

/** GET方法带参数 */
- (void)getDataWithUrl:(NSString *)urlStr parameters:(id)parameters  success:(void (^)(id json))success fail:(void (^)(NSError *error))fail;

/** POST方法 */
- (void)postDataWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))fail;

/** post上传图片方法(file) */
- (void)postImageWithURL:(NSString *)url parameters:(id)parameters iconImage:(UIImage *)iconImage imageName:(NSString *)imageName progress:(void (^)(NSProgress *progress))progress success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))fail;

/** post上传图片方法 */
- (void)postBase64ImageWithURL:(NSString *)url image:(UIImage *)image type:(NSInteger)type success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))fail;

/** post上传多图片的方法 */
- (void)postWithURL:(NSString *)url parameters:(id)parameters imageArrays:(NSMutableArray *)imageArrays name:(NSString *)name success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))fail;

KSingleToolH(AFNTool);

@end
