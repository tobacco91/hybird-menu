//
//  HttpClient.m
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/5/29.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import "HttpClient.h"

@implementation HttpClient
+ (HttpClient *)defaultClient
{
    static HttpClient *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)requestWithPath:(NSString *)url
                 method:(NSInteger)method
             parameters:(id)parameters
         prepareExecute:(PrepareExecuteBlock) prepare
               progress:(void (^)(NSProgress * progress))progress
                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 以json格式向服务器发送请求
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    [serializer setRemovesKeysWithNullValues:YES];
    // 处理服务器返回null
    //    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager setResponseSerializer:serializer];
    switch (method) {
        case HttpRequestGet:
            [manager GET:url parameters:parameters progress:progress success:success failure:failure];
            break;
        case HttpRequestPost:
            [manager POST:url parameters:parameters progress:progress success:success failure:failure];
            break;
        case HttpRequestPut:
            [manager PUT:url parameters:parameters success:success failure:failure];
            break;
        case HttpRequestDelete:
            [manager DELETE:url parameters:parameters success:success failure:failure];
            break;
        default:
            break;
    }
    
}


- (void)requestWithPathInHEAD:(NSString *)url
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger HEAD:url parameters:parameters success:success failure:failure];
}

+ (BOOL)isReachability:(NSString *) strUrl
{
    __block BOOL isReachability = NO;
    
    NSURL *baseURL = [NSURL URLWithString:strUrl];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithBaseURL:baseURL];
    
    NSOperationQueue *operationQueue = manager.operationQueue;
    
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                isReachability = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                isReachability = NO;
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    [manager.reachabilityManager startMonitoring];
    
    return isReachability;
}
@end
