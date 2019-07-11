//  YDPAFNetworkTool.m
//  YDPCommonProject
//
//  Created by 姚敦鹏 on 2017/5/27.
//  Copyright © 2017年 Encifang. All rights reserved.
//

#import "YDPAFNetworkTool.h"

@interface YDPAFNetworkTool ()

/** AFN请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation YDPAFNetworkTool
- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [[AFHTTPSessionManager alloc] init];
        
        //增加这几行代码；
//        AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
//        [securityPolicy setAllowInvalidCertificates:YES];
//        [_manager setSecurityPolicy:securityPolicy];
//        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        // 设置AFN能够接收的数据类型
        [_manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain", nil]];
        
        // 超时
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _manager.requestSerializer.timeoutInterval = 8.f;
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
    return _manager;
}

/** GET方法 */
- (void)getDataWithUrl:(NSString *)urlStr success:(void (^)(id json))success fail:(void (^)(NSError *error))fail
{
    ClassWeak(weakClass);
    // 判断是否有网络
    if ([weakClass internetConnection] == NO) {
        [YPProgressHUD showErrorHUDWithTitle:@"网络断开了"];
        return;
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [weakClass.manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        success ? success(responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (error.code == -1001) {
            [YPProgressHUD showErrorHUDWithTitle:@"连接超时了"];
            return ;
        }
        
        fail ? fail(error) : nil;
    }];
}
/** GET方法带参数 */
- (void)getDataWithUrl:(NSString *)urlStr parameters:(id)parameters  success:(void (^)(id json))success fail:(void (^)(NSError *error))fail
{
    ClassWeak(weakClass);
    // 判断是否有网络
    if ([weakClass internetConnection] == NO) {
        [YPProgressHUD showErrorHUDWithTitle:@"网络断开了"];
        return;
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    urlStr = [self urlAppeadToken:urlStr];
    if (strIsEmpty(urlStr)) {
        return;
    }
    [weakClass.manager GET:urlStr parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (error.code == -1001) {
            [YPProgressHUD showErrorHUDWithTitle:@"连接超时了"];
            return ;
        }
        
        fail ? fail(error) : nil;
    }];
}

/** POST方法 */
- (void)postDataWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))fail
{
    ClassWeak(weakClass);
    if (urlStr.length == 0) {
        urlStr = BaseURL;
    }
    // 判断是否有网络
    if ([weakClass internetConnection] == NO) {
        [YPProgressHUD showErrorHUDWithTitle:@"网络断开了"];
        return;
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    urlStr = [self urlAppeadToken:urlStr];
    if (strIsEmpty(urlStr)) {
        return;
    }
    [weakClass.manager POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        success ? success(responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (error.code == -1001) {
            [YPProgressHUD showErrorHUDWithTitle:@"连接超时了"];
            return ;
        }
        
        fail ? fail(error) : nil;
    }];
}

/** post上传图片方法(file) */
- (void)postImageWithURL:(NSString *)url parameters:(id)parameters iconImage:(UIImage *)iconImage imageName:(NSString *)imageName progress:(void (^)(NSProgress *progress))progress success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))fail
{
    ClassWeak(weakClass);
    // 判断是否有网络
    if ([weakClass internetConnection] == NO) {
        [YPProgressHUD showErrorHUDWithTitle:@"网络断开了"];
        return;
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    url = [self urlAppeadToken:url];
    if (strIsEmpty(url)) {
        return;
    }
    [weakClass.manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(iconImage, 0.2)
                                    name:@"img"//关键字
                                fileName:imageName
         
                                mimeType:@"image/jpg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        success ? success(responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (error.code == -1001) {
            [YPProgressHUD showErrorHUDWithTitle:@"连接超时了"];
            return ;
        }
        
        fail ? fail(error) : nil;
    }];
}

/** post 上传图片方法 (base64) */
- (void)postBase64ImageWithURL:(NSString *)url image:(UIImage *)image type:(NSInteger)type success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))fail
{
    ClassWeak(weakClass);
    if (url.length == 0) {
        url = BaseURL;
    }
    // 判断是否有网络
    if ([weakClass internetConnection] == NO) {
        [YPProgressHUD showErrorHUDWithTitle:@"网络断开了"];
        return;
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSData *data = UIImageJPEGRepresentation(image, 0.4f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    parameters[@"img"] = [NSString stringWithFormat:@"data:image/jpg;base64,%@",encodedImageStr];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    url = [self urlAppeadToken:url];
    if (strIsEmpty(url)) {
        return;
    }
    [weakClass.manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        success ? success(responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (error.code == -1001) {
            [YPProgressHUD showErrorHUDWithTitle:@"连接超时了"];
            return ;
        }
        
        fail ? fail(error) : nil;
    }];
}

/** post上传多图片的方法 */
- (void)postWithURL:(NSString *)url parameters:(id)parameters imageArrays:(NSMutableArray *)imageArrays name:(NSString *)name success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))fail
{
    ClassWeak(weakClass);
    // 判断是否有网络
    if ([weakClass internetConnection] == NO) {
        [YPProgressHUD showErrorHUDWithTitle:@"网络断开了"];
        return;
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    url = [self urlAppeadToken:url];
    if (strIsEmpty(url)) {
        return;
    }
    [weakClass.manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i < imageArrays.count; i++) {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(imageArrays[i], 0.2)
                                        name:@"img[]"//关键字
                                    fileName:name
                                    mimeType:@"image/png"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        DLog(@"上传进度 == %@",uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        success ? success(responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (error.code == -1001) {
            [YPProgressHUD showErrorHUDWithTitle:@"连接超时了"];
            return ;
        }
        
        fail ? fail(error) : nil;
    }];

}

-(NSString *)urlAppeadToken:(NSString *)urlStr {
    
    if (![urlStr hasPrefix:@"http:"]) {
        NSString *host = [self getHostStr];
        if (strIsEmpty(host)) {
            return nil;
        }
        urlStr = [host stringByAppendingString:urlStr];
    }
    NSString *token = [kUserDefaults valueForKey:USER_TOKEN];
    if (strIsEmpty(token)) {
        return urlStr;
    }
    
    urlStr = [urlStr stringByAppendingFormat:@"?token=%@&app=2",token];
    return urlStr;
}

- (NSString *)getHostStr {

    NSString *host = [NSString stringWithFormat:@"https://%@%@",@"%@",BaseURL];
    
    NSString *region_id = [kUserDefaults valueForKey:USER_CHOOCE_REGION_ID];
    if (region_id.integerValue == 11) {
        host = [NSString stringWithFormat:host,@"shouquandating"];
    } else if (region_id.integerValue == 12) {
        host = [NSString stringWithFormat:host,@"dashengzhongyu"];
    } else if (region_id.integerValue == 13) {
        host = [NSString stringWithFormat:host,@"liuliuxianyue"];
    } else if (region_id.integerValue == 14) {
        host = [NSString stringWithFormat:host,@"lianyundating"];
    } else {
        [YPProgressHUD showErrorHUDWithTitle:@"当前平台尚未开放"];
        return nil;
    }
    
    return host;
}

- (void)dealloc
{
    // 停止所有的操作
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.manager.operationQueue cancelAllOperations];
}

KSingleToolM(AFNTool);

@end
