//
//  MainViewController.m
//  LoginApi
//
//  Created by 汪洋 on 14/12/17.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "MainViewController.h"
#import "LoginApi.h"
#import "MD5.h"
#import "LoginManager.h"
@interface MainViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic)int heigh;
@property(nonatomic,strong)LoginManager *login;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.login = [LoginManager sharedLoginManager];
    
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    startBtn.frame = CGRectMake(235, 20, 50, 50);
    [startBtn addTarget:self action:@selector(startLoginApi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    
    self.scrollView = [[UIScrollView alloc ] initWithFrame:CGRectMake(0, 60, 320, 508)];
    //self.scrollView.backgroundColor = [UIColor yellowColor];
    self.scrollView.contentSize = CGSizeMake(320, 508);
    [self.view addSubview:self.scrollView];
    
    self.heigh = 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//注册
-(void)startLoginApi{
    
    NSLog(@"%@,%@",self.login.userId,self.login.token);
    [self.scrollView addSubview:[self getLabel:@"开始注册"]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@cellPhone forKey:@"cellPhone"];
    [dic setValue:[MD5 md5HexDigest:@"123"] forKey:@"password"];
    [dic setValue:@"mobile" forKey:@"deviceType"];
    [dic setValue:@"1" forKey:@"barCode"];
    [dic setValue:@userName forKey:@"userName"];
    [self.scrollView addSubview:[self getLabel:[NSString stringWithFormat:@"参数：%@",dic]]];
    [LoginApi RegisterWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [self.scrollView addSubview:[self getLabel:[NSString stringWithFormat:@"返回值：%@",posts[0]]]];
            if(posts[0][@"d"]){
                if(posts[0][@"d"][@"status"]){
                    if(posts[0][@"d"][@"status"][@"statusCode"]){
                        NSNumber *errorcode = posts[0][@"d"][@"status"][@"statusCode"];
                        switch ([errorcode intValue]) {
                            case 1308:
                                [self.scrollView addSubview:[self getLabel:@"手机号已存在"]];
                                break;
                            case 1325:
                                [self.scrollView addSubview:[self getLabel:@"用户名已经存在"]];
                                break;
                            case 1310:
                                [self.scrollView addSubview:[self getLabel:@"激活码无效"]];
                                break;
                            case 1303:
                                [self.scrollView addSubview:[self getLabel:@"注册失败，系统异常"]];
                                break;
                            case 1301:
                                [self.scrollView addSubview:[self getLabel:@"参数异常信息提示（具体见返回信息）"]];
                                break;
                            case 1300:
                                if(posts[0][@"d"][@"data"]){
                                    if(![posts[0][@"d"][@"data"] isKindOfClass:[NSDictionary class]]){
                                        [self.scrollView addSubview:[self getLabel:[NSString stringWithFormat:@"返回数据类型为%@,应该为%@",[posts[0][@"d"][@"data"] class],[NSDictionary class]]]];
                                        [self hasRegistrField:posts[0][@"d"][@"data"][0]];
                                    }else{
                                        [self hasRegistrField:posts[0][@"d"][@"data"]];
                                    }
                                }else{
                                    [self.scrollView addSubview:[self getLabel:@"缺少key====> data"]];
                                }
                                break;
                            default:
                                break;
                        }
                    }else{
                        [self.scrollView addSubview:[self getLabel:@"缺少key====> statusCode"]];
                    }
                }else{
                    [self.scrollView addSubview:[self getLabel:@"缺少key====> status"]];
                }
            }else{
                [self.scrollView addSubview:[self getLabel:@"缺少key====> d"]];
            }
        }else{
            [self.scrollView addSubview:[self getLabel:@"注册接口请求失败"]];
            [self.scrollView addSubview:[self getLabel:[NSString stringWithFormat:@"%@",error]]];
        }
        [self gotoLogin];
    } dic:dic];
}

//登录
-(void)gotoLogin{
     NSLog(@"%@,%@",self.login.userId,self.login.token);
    [self.scrollView addSubview:[self getLabel:@"开始登陆"]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@userName forKey:@"userName"];
    [dic setValue:[MD5 md5HexDigest:@"123"] forKey:@"password"];
    [dic setValue:@"mobile" forKey:@"deviceType"];
    [self.scrollView addSubview:[self getLabel:[NSString stringWithFormat:@"参数：%@",dic]]];
    [LoginApi LoginWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            //NSLog(@"%@",[NSString stringWithFormat:@"%@",posts[0]]);
            [self.scrollView addSubview:[self getLabel:[NSString stringWithFormat:@"返回值：%@",posts[0]]]];
            if(posts[0][@"d"]){
                if(posts[0][@"d"][@"status"]){
                    if(posts[0][@"d"][@"status"][@"statusCode"]){
                        NSNumber *errorcode = posts[0][@"d"][@"status"][@"statusCode"];
                        switch ([errorcode intValue]) {
                            case 1320:
                                [self.scrollView addSubview:[self getLabel:@"用户名不存在"]];
                                break;
                            case 1321:
                                [self.scrollView addSubview:[self getLabel:@"你已经被拉黑"]];
                                break;
                            case 1322:
                                [self.scrollView addSubview:[self getLabel:@"你已经禁止登录"]];
                                break;
                            case 1324:
                                [self.scrollView addSubview:[self getLabel:@"密码错误"]];
                                break;
                            case 1325:
                                [self.scrollView addSubview:[self getLabel:@"用户名已存在"]];
                                break;
                            case 1300:
                                if(posts[0][@"d"][@"data"]){
                                    if(![posts[0][@"d"][@"data"] isKindOfClass:[NSDictionary class]]){
                                        [self.scrollView addSubview:[self getLabel:[NSString stringWithFormat:@"返回数据类型为%@,应该为%@",[posts[0][@"d"][@"data"] class],[NSDictionary class]]]];
                                        [self hasLoginField:posts[0][@"d"][@"data"][0]];
                                    }else{
                                        [self hasLoginField:posts[0][@"d"][@"data"]];
                                        [self.scrollView addSubview:[self getLabel:@"登录成功!"]];
                                    }
                                }else{
                                    [self.scrollView addSubview:[self getLabel:@"缺少key====> data"]];
                                }
                                break;
                            default:
                                break;
                        }
                    }else{
                        [self.scrollView addSubview:[self getLabel:@"缺少key====> statusCode"]];
                    }
                }else{
                    [self.scrollView addSubview:[self getLabel:@"缺少key====> status"]];
                }
            }else{
                [self.scrollView addSubview:[self getLabel:@"缺少key====> d"]];
            }
        }else{
            [self.scrollView addSubview:[self getLabel:@"登录接口请求失败"]];
            [self.scrollView addSubview:[self getLabel:[NSString stringWithFormat:@"%@",error]]];
        }
        [self InformationImproved];
    } dic:dic];
}

//完善用户信息
-(void)InformationImproved{
    [self.scrollView addSubview:[self getLabel:@"完善用户信息"]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@"自动测试号" forKey:@"userName"];
    [dic setValue:self.login.userId forKey:@"userId"];
    [dic setValue:@"mobile" forKey:@"realName"];
    [dic setValue:@"男" forKey:@"sex"];
    [dic setValue:@"上海" forKey:@"locationCity"];
    [dic setValue:@"2014-12-25" forKey:@"birthday"];
    [dic setValue:@"白羊" forKey:@"constellation"];
    [dic setValue:@"A" forKey:@"bloodType"];
    [dic setValue:@"abc@123.com" forKey:@"email"];
    [dic setValue:@"虹口区" forKey:@"provice"];
    [dic setValue:@"上海" forKey:@"city"];
    [dic setValue:@"上海" forKey:@"district"];
    [self.scrollView addSubview:[self getLabel:[NSString stringWithFormat:@"参数：%@",dic]]];
    [LoginApi PostInformationImprovedWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [self.scrollView addSubview:[self getLabel:[NSString stringWithFormat:@"返回值：%@",posts[0]]]];
            if(posts[0][@"d"]){
                if(posts[0][@"d"][@"status"]){
                    if(posts[0][@"d"][@"status"][@"statusCode"]){
                        NSNumber *errorcode = posts[0][@"d"][@"status"][@"statusCode"];
                        switch ([errorcode intValue]) {
                            case 1306:
                                [self.scrollView addSubview:[self getLabel:@"更新失败"]];
                                break;
                            case 1301:
                                [self.scrollView addSubview:[self getLabel:@"参数异常信息提示（具体见返回信息）"]];
                                break;
                            case 1300:
                                [self.scrollView addSubview:[self getLabel:@"更新成功"]];
                                break;
                            default:
                                break;
                        }
                    }else{
                        [self.scrollView addSubview:[self getLabel:@"缺少key====> statusCode"]];
                    }
                }else{
                    [self.scrollView addSubview:[self getLabel:@"缺少key====> status"]];
                }
            }else{
                [self.scrollView addSubview:[self getLabel:@"缺少key====> d"]];
            }
        }else{
            [self.scrollView addSubview:[self getLabel:@"登录接口请求失败"]];
            [self.scrollView addSubview:[self getLabel:[NSString stringWithFormat:@"%@",error]]];
        }
        [self GetUserInformation];
    } dic:dic];
}

//获取用户信息
-(void)GetUserInformation{
    [self.scrollView addSubview:[self getLabel:@"获取用户信息"]];
    [LoginApi GetUserInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [self.scrollView addSubview:[self getLabel:[NSString stringWithFormat:@"返回值：%@",posts[0]]]];
            if(posts[0][@"d"]){
                if(posts[0][@"d"][@"status"]){
                    if(posts[0][@"d"][@"status"][@"statusCode"]){
                        NSNumber *errorcode = posts[0][@"d"][@"status"][@"statusCode"];
                        switch ([errorcode intValue]) {
                            case 1303:
                                [self.scrollView addSubview:[self getLabel:@"获取失败，系统异常"]];
                                break;
                            case 1300:
                                [self.scrollView addSubview:[self getLabel:@"获取成功"]];
                                if(posts[0][@"d"][@"data"]){
                                    if(posts[0][@"d"][@"data"][@"baseInformation"]){
                                        if(![posts[0][@"d"][@"data"][@"baseInformation"] isKindOfClass:[NSDictionary class]]){
                                            [self.scrollView addSubview:[self getLabel:[NSString stringWithFormat:@"返回数据类型为%@,应该为%@",[posts[0][@"d"][@"data"][@"baseInformation"] class],[NSDictionary class]]]];
                                        }else{
                                            
                                        }
                                    }else{
                                        [self.scrollView addSubview:[self getLabel:@"缺少key====> baseInformation"]];
                                    }
                                    
                                    if(posts[0][@"d"][@"data"][@"userProjects"]){
                                    
                                    }else{
                                        [self.scrollView addSubview:[self getLabel:@"缺少key====> userProjects"]];
                                    }
                                }else{
                                    [self.scrollView addSubview:[self getLabel:@"缺少key====> data"]];
                                }
                                break;
                            default:
                                break;
                        }
                    }else{
                        [self.scrollView addSubview:[self getLabel:@"缺少key====> statusCode"]];
                    }
                }else{
                    [self.scrollView addSubview:[self getLabel:@"缺少key====> status"]];
                }
            }else{
                [self.scrollView addSubview:[self getLabel:@"缺少key====> d"]];
            }
        }else{
            [self.scrollView addSubview:[self getLabel:@"登录接口请求失败"]];
            [self.scrollView addSubview:[self getLabel:[NSString stringWithFormat:@"%@",error]]];
        }
    } userId:self.login.userId];
}

//判断注册字段
-(void)hasRegistrField:(NSMutableDictionary *)dic{
    if(![dic.allKeys containsObject:@"userId"]){
        [self.scrollView addSubview:[self getLabel:@"缺少字段====> userId"]];
    }else{
        self.login.userId = dic[@"userId"];
    }
    
    if(![dic.allKeys containsObject:@"userName"]){
        [self.scrollView addSubview:[self getLabel:@"缺少字段====> userName"]];
    }
    
    if(![dic.allKeys containsObject:@"userToken"]){
        [self.scrollView addSubview:[self getLabel:@"缺少字段====> userToken"]];
    }
    
    if(![dic.allKeys containsObject:@"deviceToken"]){
        [self.scrollView addSubview:[self getLabel:@"缺少字段====> deviceToken"]];
    }else{
        self.login.token = dic[@"deviceToken"];
    }
    
    if(![dic.allKeys containsObject:@"userType"]){
        [self.scrollView addSubview:[self getLabel:@"缺少字段====> userType"]];
    }
    
    if(![dic.allKeys containsObject:@"hasCompany"]){
        [self.scrollView addSubview:[self getLabel:@"缺少字段====> hasCompany"]];
    }
}

//判断登录字段
-(void)hasLoginField:(NSMutableDictionary *)dic{
    if(![dic.allKeys containsObject:@"userId"]){
        [self.scrollView addSubview:[self getLabel:@"缺少字段====> userId"]];
    }else{
        self.login.userId = dic[@"userId"];
    }
    
    if(![dic.allKeys containsObject:@"userName"]){
        [self.scrollView addSubview:[self getLabel:@"缺少字段====> userName"]];
    }
    
    if(![dic.allKeys containsObject:@"userToken"]){
        [self.scrollView addSubview:[self getLabel:@"缺少字段====> userToken"]];
    }
    
    if(![dic.allKeys containsObject:@"deviceToken"]){
        [self.scrollView addSubview:[self getLabel:@"缺少字段====> deviceToken"]];
    }else{
        self.login.token = dic[@"deviceToken"];
    }
    
    if(![dic.allKeys containsObject:@"userType"]){
        [self.scrollView addSubview:[self getLabel:@"缺少字段====> userType"]];
    }
    
    if(![dic.allKeys containsObject:@"hasCompany"]){
        [self.scrollView addSubview:[self getLabel:@"缺少字段====> hasCompany"]];
    }
}

//判断用户信息字段
-(void)hasUserInformationField:(NSMutableDictionary *)dic{
    if(![dic.allKeys containsObject:@"userName"]){
        [self.scrollView addSubview:[self getLabel:@"缺少字段====> userName"]];
    }else{
        self.login.userId = dic[@"userId"];
    }
    
    if(![dic.allKeys containsObject:@"userName"]){
        [self.scrollView addSubview:[self getLabel:@"缺少字段====> userName"]];
    }
    
    if(![dic.allKeys containsObject:@"userToken"]){
        [self.scrollView addSubview:[self getLabel:@"缺少字段====> userToken"]];
    }
    
    if(![dic.allKeys containsObject:@"deviceToken"]){
        [self.scrollView addSubview:[self getLabel:@"缺少字段====> deviceToken"]];
    }else{
        self.login.token = dic[@"deviceToken"];
    }
    
    if(![dic.allKeys containsObject:@"userType"]){
        [self.scrollView addSubview:[self getLabel:@"缺少字段====> userType"]];
    }
    
    if(![dic.allKeys containsObject:@"hasCompany"]){
        [self.scrollView addSubview:[self getLabel:@"缺少字段====> hasCompany"]];
    }
}

-(UILabel *)getLabel:(NSString *)str{
    NSMutableAttributedString* attributedText=[[NSMutableAttributedString alloc]initWithString:str];
    UILabel* contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines =0;
    contentLabel.font = [UIFont systemFontOfSize:15];
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.attributedText=attributedText;
    CGSize size =CGSizeMake(290,CGFLOAT_MAX);
    CGSize actualsize =[str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    contentLabel.frame =CGRectMake(10,self.heigh, actualsize.width, actualsize.height);
    self.heigh +=actualsize.height;
    if(self.heigh>508){
        self.scrollView.contentSize = CGSizeMake(320, self.heigh);
    }
    return contentLabel;
}

-(NSString *)StrStage:(NSString *)str{
    NSString *string = nil;
    if([[NSString stringWithFormat:@"%@",str] isEqualToString:@"(null)"]||[[NSString stringWithFormat:@"%@",str] isEqualToString:@"<null>"]||[[NSString stringWithFormat:@"%@",str] isEqualToString:@" "]){
        string = @"";
    }else{
        string = str;
    }
    return string;
}
@end
