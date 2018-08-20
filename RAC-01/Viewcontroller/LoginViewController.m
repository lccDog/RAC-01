//
//  LoginViewController.m
//  RAC-01
//
//  Created by lcc on 2018/8/14.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "ReactiveObjC.h"
#import "LoginVIewModel.h"
#import "HomeViewController.h"
@interface LoginviewController ()

@property (nonatomic,strong) LoginView *loginView;

@property (nonatomic,strong) LoginVIewModel *loginViewModel;


@end

@implementation LoginviewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self creatLoginView];
    

}

- (void)creatLoginView{
    _loginView = [LoginView initView];
    _loginView.frame = self.view.frame;
    [self.view addSubview:_loginView];
    _loginView.layer.borderWidth = 2;
    _loginView.layer.borderColor = [UIColor blueColor].CGColor;
    
    RAC(self.loginViewModel, mobile) = _loginView.phoneTextField.rac_textSignal;
    RAC(self.loginViewModel, loginPassword) = _loginView.pwdTextField.rac_textSignal;
    RAC(self.loginView.loginBtn, enabled) = _loginViewModel.loginButtonEnableSignal;
    
    /*登录action*/
    [[_loginView.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self.loginViewModel.loginCommad execute:nil];
        
    }];


    
    /*返回数据*/
    [[self.loginViewModel.loginCommad.executionSignals flatten] subscribeNext:^(RACTuple *tuple) {
        HomeViewController *vc = [[HomeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }];
}


#pragma mark - lazy initialization
- (LoginVIewModel *)loginViewModel {
    if (!_loginViewModel) {
        _loginViewModel = [[LoginVIewModel alloc] init];
    }
    return _loginViewModel;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
