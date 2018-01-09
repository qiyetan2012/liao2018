//
//  XMGHttpManager.m
//  码哥课堂1
//
//  Created by 小码哥 on 2016/12/17.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGHttpManager.h"
#import <AFNetworking.h>

@implementation XMGHttpManager
+ (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress *))uploadProgress success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    // 管理请求和响应
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 自定义请求
    AFJSONRequestSerializer *res = [AFJSONRequestSerializer serializer];
    mgr.requestSerializer = res;
    
    // 自定义响应
    AFJSONResponseSerializer *rsp = [AFJSONResponseSerializer serializer];
    rsp.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    mgr.responseSerializer = rsp;
    
    return [mgr POST:URLString parameters:parameters progress:uploadProgress success:success failure:failure];
}
@end
