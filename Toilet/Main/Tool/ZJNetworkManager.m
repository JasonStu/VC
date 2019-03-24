//
//  ZJNetworkManager.m
//  Shuweiuser
//
//  Created by kunge on 2017/7/10.
//  Copyright © 2017年 zijing. All rights reserved.
//

#import "ZJNetworkManager.h"
#import "Reachability.h"

@implementation ZJNetworkManager

#pragma mark -  单例类初始化
+ (instancetype)shareNetworkManager
{
    static ZJNetworkManager *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.afManager = [AFHTTPSessionManager manager];
        //设置超时时间
        instance.afManager.requestSerializer.timeoutInterval = 20;
        instance.afManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                                    @"text/html",
                                                                    @"text/json",
                                                                    @"text/javascript",
                                                                    @"text/plain",
                                                                    @"application/text",
                                                                    nil];
        instance.afManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        instance.afManager.requestSerializer = [AFJSONRequestSerializer serializer];
//        instance.afManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
    });
    return instance;
}



#pragma mark - POST请求
- (void)POSTWithURL:(NSString *)url Parameter:(NSDictionary *)param success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    if ([url hasPrefix:@"http"]) {

    }else
    {
        url = [NSString stringWithFormat:@"%@%@",DomainURL,url];
    }

    [self.afManager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求结果: %@",responseObject);
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        success(dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"=====请求失败=====%@",error);
        failure(task , error,@"");
        if (![self isExistenceNetwork]) {
            failure(task,error,@"网络有问题，请稍后再试");
        }else{
            failure(task , error,@"");
        }
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
}

#pragma mark - GET请求
- (void)GETWithURL:(NSString*)url Parameter:(NSDictionary *)param success:(SuccessBlock)success failure:(FailureBlock)failure
{
    url = [NSString stringWithFormat:@"%@%@",DomainURL,url];
    NSLog(@"请求url = %@  参数 = %@",url,param);
    
    [self.afManager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"返回参数 = %@ ",responseObject);
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        success(dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"=====请求失败=====%@",error);
        failure(task , error,@"");
    }];
}


#pragma mark AFNetworking上传图片请求
- (void)AFUPLOADImageWithUrl:(NSString *)url Parameter:(NSDictionary *)param updata:(UploadDataBlock)uploadDataBlock success:(SuccessBlock)success failure:(FailureBlock)failure
{
    url = [NSString stringWithFormat:@"%@%@",DomainURL,url];
    NSLog(@"请求url = %@  参数 = %@",url,param);
    [self.afManager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        uploadDataBlock(formData);
        uploadDataBlock(formData);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = responseObject;
        [self dealWithReturnData:dict];
        success(responseObject);
        NSLog(@"返回参数 = %@ ",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"=====请求失败=====%@",error);
        failure(task , error,@"");
    }];
}

#pragma mark 返回数据状态码判断
-(void)dealWithReturnData:(NSDictionary *)dic{
    //sessionId失效重新登录
    if (([dic[@"status"]integerValue] == 5000101) || ([dic[@"status"]integerValue] == 5000102)) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:RELOGIN object:nil];
    }
}

#pragma mark 获取随机字符
-(NSString *)randomStringWithLength:(int)len{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    return randomString;
}

#pragma mark 获取当前时间戳
-(NSString *)getDateTimeString{
    NSDateFormatter *formatter;
    NSString        *dateString;
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd_HH:mm:ss"];
    dateString = [formatter stringFromDate:[NSDate date]];
    return dateString;
}

#pragma mark 检测网络状态
- (BOOL)isExistenceNetwork
{
    BOOL isExistenceNetwork = false;
    Reachability *reachAblitity = [Reachability reachabilityForInternetConnection];
    switch ([reachAblitity currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork=FALSE;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork=TRUE;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork=TRUE;
            break;
    }
    return isExistenceNetwork;
}

@end
