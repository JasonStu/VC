
//网络请求类

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef enum {
    ZJNetWorkStateWifi,
    ZJNetWorkStatePhone,
    ZJNetWorkStateNone
}ZJNetWorkState ;

typedef enum {
    GETType = 0,
    POSTType = 1,
    PUTType = 2,
    DELETEType = 3
}ZJRequestType ;


/**
 *  请求成功后的数据简单处理后的回调
 */
typedef void (^SuccessBlock) (NSDictionary *resultDic);
/**
 *  请求失败后的响应及错误实例
 */
typedef void (^FailureBlock) (NSURLSessionDataTask *  task,NSError *error,NSString *description);
/**
 *  上传图片的blcok
 */
typedef void (^UploadDataBlock) (id<AFMultipartFormData> formData);
typedef void (^SingleSuccessBlock)(NSString *key);
typedef void (^SingleFailureBlock)(NSError *error);
typedef void (^ZJQiNiuSuccessBlock)(NSString *key);
typedef void (^ZJQiNiuFailureBlock)(NSError *error);

@interface ZJNetworkManager : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *afManager;
@property (nonatomic, assign) ZJNetWorkState ZJNetWorkState;

@property (copy, nonatomic) void (^SingleSuccessBlock)(NSString *key);
@property (copy, nonatomic) void (^SingleFailureBlock)();


/*------------------单例声明---------------------------*/
+ (instancetype)shareNetworkManager;

#pragma mark - body方式请求
/*-------------------------body方式请求------------------------------*/
/**
 *  异步POST请求:以body方式,支持数组
 *  @param url     请求的url
 *  @param body    参数字典
 *  @param requestType    请求类型
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)RequestBodyWithUrl:(NSString *)url requestType:(ZJRequestType)requestType body:(NSDictionary *)body success:(SuccessBlock)success failure:(void(^)(NSError *error))failure;


#pragma mark - 参数params方式请求
/*-------------------------参数params方式请求------------------------------*/
/**
 *  请求网络接口,返回请求的响应接口,并作初期数据处理
 *
 *  @param url        网络请求的接口
 *  @param param          请求所带的参数
 *  @param success 成功请求后得到的响应,此响应包括服务器业务逻辑异常结果,只接收服务器业务逻辑状态码为200的结果
 *  @param failure    服务器响应不正常,网络连接失败返回的响应结果
 */

/*------------------POST---------------------------*/
- (void)POSTWithURL:(NSString*)url Parameter:(NSDictionary *)param success:(SuccessBlock)success failure:(FailureBlock)failure;

/*------------------GET---------------------------*/
- (void)GETWithURL:(NSString*)url Parameter:(NSDictionary *)param success:(SuccessBlock)success failure:(FailureBlock)failure;

/*------------------UPLOAD---------------------------*/

// 上传单张图片
- (void)UPLOADImage:(UIImage *)image progress:(void (^)(CGFloat))progressBlock success:(SuccessBlock)success failure:(FailureBlock)failure;
// 上传doc文件
- (void)UPLOADDoc:(NSData *)docData progress:(void (^)(CGFloat))progressBlock success:(SuccessBlock)success failure:(FailureBlock)failure;

// AFNetworking方式：上传图片和一般参数的接口
- (void)AFUPLOADImageWithUrl:(NSString *)url Parameter:(NSDictionary *)param updata:(UploadDataBlock)uploadDataBlock success:(SuccessBlock)success failure:(FailureBlock)failure;


// 七牛方式：上传单张图片
- (void)QNUPLOADWithImage:(UIImage *)image progress:(void (^)(CGFloat))progressBlock success:(ZJQiNiuSuccessBlock)singleSuccess failure:(ZJQiNiuFailureBlock)singleFailure;
//七牛方式：上传图片数组
- (void)QNUPLOADWithImages:(NSArray *)imageArray progress:(void (^)(CGFloat totalProgress,NSInteger currentIndex,NSString *url))progrevoidss success:(void (^)(NSArray *imageUrlA))success failure:(void (^)(void))failure;
//七牛方式：上传NSData文件
- (void)QNUPLOADWithData:(NSData *)data progress:(void (^)(double uploadProgress))progressBlock success:(ZJQiNiuSuccessBlock)SingleSuccess failure:(ZJQiNiuFailureBlock)SingleFailure;

@end
