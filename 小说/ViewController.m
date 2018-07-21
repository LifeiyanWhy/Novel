//
//  ViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/3/29.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "ViewController.h"
#import "NOVSigninView.h"
#import "NOVSignupView.h"
#import "NOVSignModel.h"
#import "NOVSignUpNextView.h"

@interface ViewController ()<UITextFieldDelegate>

@property(nonatomic,strong) NOVSigninView *signView ;

@property(nonatomic,strong) NOVSignupView *signUpView;

@property(nonatomic,strong) NOVSignUpNextView *signUpNextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _signView = [[NOVSigninView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_signView];
    _signView.accountTextField.delegate = self;
    _signView.passwardTextField.delegate = self;
    [_signView.signinButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [_signView.signupButton addTarget:self action:@selector(willSignUp) forControlEvents:UIControlEventTouchUpInside];
    
    _signUpView = [[NOVSignupView alloc] initWithFrame:self.view.frame];
    _signUpView.accountTextField.delegate = self;
    _signUpView.accountTextField.delegate = self;
    _signUpView.verifyTextfield.delegate = self;
    _signUpView.hidden = YES;
    [self.view addSubview:_signUpView];
    [_signUpView.verifyeButton addTarget:self action:@selector(obtainVerify) forControlEvents:UIControlEventTouchUpInside];
    [_signUpView.nextButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
}

- (void)login{
    if (_signView.accountTextField.text.length <= 0 || _signView.passwardTextField.text.length <= 0) {
        [self showAlertActionWithTitle:@"账号密码不能为空"];
        return;
    }
    NOVSignModel *loginModel = [[NOVSignModel alloc] init];
    [loginModel loginWithAccount:_signView.accountTextField.text  password:_signView.passwardTextField.text success:^(id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        //登录成功
        [[NSNotificationCenter defaultCenter] postNotificationName:@"signinSucceed" object:nil];
        [loginModel obtainFollowList];//获取关注列表
    } failure:^(NSError * _Nonnull error) {
        if (error.code == -1009) {
            [self showAlertActionWithTitle:@"网络不可用,请重试！"];
        }else{
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:&error];
            //status为1代表登录失败，账号或密码错误。
            if ([[NSString stringWithFormat:@"%@",dict[@"status"]] isEqualToString:@"1"]) {
                [self showAlertActionWithTitle:@"账号或密码错误"];
            }
        }
    }];
}

//点击注册button后进入注册页面（在登录界面点击注册时执行）
-(void)willSignUp{
    _signUpView.hidden = NO;
}

//获取验证码
-(void)obtainVerify{
    if (_signUpView.accountTextField.text.length != 11) {
        [self showAlertActionWithTitle:@"手机号为十一位数字"];
        return;
    }
}

-(void)next{
    //检测验证码是否正确
    if (_signUpView.accountTextField.text.length != 11) {
        [self showAlertActionWithTitle:@"手机号为十一位数字"];
        return;
    }
    _signUpView.hidden = YES;
    _signUpNextView = [[NOVSignUpNextView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_signUpNextView];
    [_signUpNextView.signUpButton addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
}

-(void)signUp{
    if (_signUpNextView.usernameTextField.text.length < 2 || _signUpNextView.usernameTextField.text.length > 20) {
        [self showAlertActionWithTitle:@"用户名为2～20位"];
        return;
    }else if (_signUpNextView.passwardTextField.text.length < 6 || _signUpNextView.passwardTextField.text.length > 30){
        [self showAlertActionWithTitle:@"密码为6～30位"];
        return;
    }else if (_signUpNextView.passwardTextField.text != _signUpNextView.inputPswdAgain.text){
        [self showAlertActionWithTitle:@"输入密码不一致"];
        return;
    }
    //输入成功之后注册
    __block ViewController *tempself = self;
    NOVSignModel *signupModel = [[NOVSignModel alloc] init];
    [signupModel signUpWithAccount:_signUpView.accountTextField.text username:_signUpNextView.usernameTextField.text passward:_signUpNextView.passwardTextField.text success:^(id  _Nullable responseObject) {
        if ([[NSString stringWithFormat:@"%@", responseObject[@"status"]] isEqualToString:@"0"]) {
            //0 注册成功返回登录界面
            [tempself showAlertActionWithTitle:@"注册成功，请登录！"];
            _signUpNextView.hidden = YES;
        }
    } failure:^(NSError * _Nonnull error) {
    }];
}

- (void)showAlertActionWithTitle:(NSString *)title{
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *messageAlert = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:nil];
    [alertControl addAction:messageAlert];
    UIAlertAction *alert = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
    [alertControl addAction:alert];
    [self presentViewController:alertControl animated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
