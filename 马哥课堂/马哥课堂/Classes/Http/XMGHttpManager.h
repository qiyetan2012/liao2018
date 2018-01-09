//
//  XMGHttpManager.h
//  码哥课堂1
//
//  Created by 小码哥 on 2016/12/17.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGHttpManager : NSObject

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                      progress:(void (^)(NSProgress *progress))uploadProgress
                       success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

@end
