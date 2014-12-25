//
//  LoginManager.h
//  LoginApi
//
//  Created by 汪洋 on 14/12/25.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginManager : NSObject
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *token;
+(LoginManager *)sharedLoginManager;
@end
