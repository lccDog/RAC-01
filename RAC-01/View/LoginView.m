//
//  LoginView.m
//  RAC-01
//
//  Created by lcc on 2018/8/14.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

+ (instancetype)initView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
