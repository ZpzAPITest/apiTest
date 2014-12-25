//
//  LoginApiTests.m
//  LoginApiTests
//
//  Created by 汪洋 on 14/12/17.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "LoginApi.h"
@interface LoginApiTests : XCTestCase

@end

@implementation LoginApiTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testIsUrl{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@"01234567890" forKey:@"userName"];
    [dic setValue:@"123456" forKey:@"password"];
    [dic setValue:@"mobile" forKey:@"deviceType"];
    NSURLSessionTask *task = [LoginApi LoginWithBlock:^(NSMutableArray *posts, NSError *error) {
        NSLog(@"asdfasdfasdf");
        if(!error){
            NSLog(@"asdfasdfasdf");
        }
    } dic:dic];
    NSLog(@"%@",task.currentRequest.URL);
    NSLog(@"%@",task.response);
    //XCTAssertEqualObjects(serverAddress, <#expression2, ...#>)
}

@end
