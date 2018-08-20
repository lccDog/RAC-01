//
//  LoginVIewModel.m
//  RAC-01
//
//  Created by lcc on 2018/8/14.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "LoginVIewModel.h"
#import "AFNetworking.h"
#import "UserModel.h"
#import "MJExtension.h"

@implementation LoginVIewModel

- (instancetype)init
{
    if (self = [super init])
    {
        [self setup];
    }
    
    return self;
}
- (void)setup {
    
    self.loginButtonEnableSignal = [RACSignal combineLatest:@[RACObserve(self, mobile), RACObserve(self, loginPassword)] reduce:^id(NSString *username, NSString *password){
        return @(username.length && password.length);
    }];
    
    self.loginCommad = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {

            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            //        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            
            self.mobile = @"18519504720";
            self.loginPassword = @"lcc123456";
            
            params[@"cellphone"] = self.mobile;
            params[@"password"] = self.loginPassword;
            params[@"loginOS"] = @"1";
            NSURL *url = [NSURL URLWithString:@"https://yf.1feikeji.com/jinyunfund/api/member/login"];
            NSString *urlStr = [NSString stringWithFormat:@"%@",url];
            [manager POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

                UserModel *userModel = [UserModel mj_objectWithKeyValues:responseObject[@"result"][@"data"]];
                [self.dataArr addObject:userModel];
                
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
            return nil;
        }];
    }];
    
    [self.loginCommad.executionSignals.switchToLatest subscribeNext:^(NSDictionary *dic) {
        
        if ([dic[@"result"][@"status"] isEqualToString:@"1"]) {
             NSLog(@"登录成功...");
        }else {
            NSLog(@"登录失败...");
        }
    }];
    
    [[self.loginCommad.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"正在登录中...");
        }
    }];
}
@end
