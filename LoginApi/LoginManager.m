//
//  LoginManager.m
//  LoginApi
//
//  Created by 汪洋 on 14/12/25.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "LoginManager.h"

@implementation LoginManager
+(LoginManager *)sharedLoginManager{
    static LoginManager *sharedLoginManagerInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLoginManagerInstance = [[LoginManager alloc] init];
        sharedLoginManagerInstance.userId = @"";
        sharedLoginManagerInstance.token = @"";
    });
    return sharedLoginManagerInstance;
}
@end
