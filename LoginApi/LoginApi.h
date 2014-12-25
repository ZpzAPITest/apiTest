//
//  LoginApi.h
//  LoginApi
//
//  Created by 汪洋 on 14/12/17.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginApi : NSObject
//登录
+ (NSURLSessionDataTask *)LoginWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic;

//注册
+ (NSURLSessionDataTask *)RegisterWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic;

//完善用户信息
+ (NSURLSessionDataTask *)PostInformationImprovedWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic;

//获取个人信息
+ (NSURLSessionDataTask *)GetUserInformationWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userId:(NSString *)userId;
@end
