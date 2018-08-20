//
//  LoginVIewModel.h
//  RAC-01
//
//  Created by lcc on 2018/8/14.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC.h"
@interface LoginVIewModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *loginPassword;

@property (nonatomic,strong)  RACSignal *loginButtonEnableSignal;
@property (nonatomic, strong) RACCommand *loginCommad;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end
