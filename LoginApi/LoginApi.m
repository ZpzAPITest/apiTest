//
//  LoginApi.m
//  LoginApi
//
//  Created by 汪洋 on 14/12/17.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "LoginApi.h"

@implementation LoginApi
//POST:
//{
//    "userName": "13812312314",
//    "password": "1234",
//    "deviceType": ":mobile || web"
//}
//
//RESPONSE:
//{
//    "d": {
//        "status": {
//            "statusCode": 1300
//        },
//        "data": [
//                 {
//                     "userId": "d85b740b-f5ca-432b-86a6-422a0569f0d1",
//                     "userToken": "0b3af34d-e9b8-4455-9220-737e68470711",
//                     "devicetoken": null
//                 }
//                 ]
//    }
//}
+ (NSURLSessionDataTask *)LoginWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"api/account/login"];
    NSLog(@"dic===>%@",dic);
    return [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON==>%@",JSON);
        NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
        [mutablePosts addObject:JSON];
        if (block) {
            block([NSMutableArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}


// post参数：
// {
// "cellPhone": ":cellPhone",
// "password": ":”password",
// "deviceType": ":mobile || web",
// "barCode": ":“123123"
// "userName": "userName"
// }
//
//
//RESPONSE:
//{
//    "d": {
//        "status": {
//            "statusCode": 1300
//        },
//        "data": [
//                 {
//                     "userId": "618e491f-2541-4467-80a8-6e0c6eb561ae",
//                     "userToken": "40f0571e-1764-4967-8808-8bd0bba6b471",
//                     "isFaceRegister": false,
//                     "faceCount": 0
//                 }
//                ]
//    }
//}
+ (NSURLSessionDataTask *)RegisterWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"api/account/register2"];
    return [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
        [mutablePosts addObject:JSON];
        if (block) {
            block([NSMutableArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

//完善用户信息
+ (NSURLSessionDataTask *)PostInformationImprovedWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic
{
    
    NSString *urlStr = [NSString stringWithFormat:@"api/account/InformationImproved"];
    return [[AFAppDotNetAPIClient sharedNewClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
        [mutablePosts addObject:JSON];
        if (block) {
            block([NSMutableArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
        
    }];
}

//获取个人信息
+ (NSURLSessionDataTask *)GetUserInformationWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userId:(NSString *)userId{
    NSString *urlStr = [NSString stringWithFormat:@"api/networking/UserDetails?userId=%@",userId];
    return [[AFAppDotNetAPIClient sharedNewClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
        [mutablePosts addObject:JSON];
        if (block) {
            block([NSMutableArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
        
    }];
}
@end
