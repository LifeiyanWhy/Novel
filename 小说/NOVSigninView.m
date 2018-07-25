//
//  NOVSigninView.m
//  小说
//
//  Created by 李飞艳 on 2018/5/6.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVSigninView.h"
#import "Masonry.h"

@implementation NOVSigninView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _accountTextField = [[UITextField alloc] init];
        [self addSubview:_accountTextField];
        
        _passwardTextField = [[UITextField alloc] init];
        [self addSubview:_passwardTextField];
   
        _signinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_signinButton];
        
        _signupButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_signupButton];
        
        _findPasswradButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_findPasswradButton];
        
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        
        _label = [[UILabel alloc] init];
        [self addSubview:_label];
    }
    return self;
}

-(void)layoutSubviews{
    self.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(self.frame.size.height*0.1);
        make.height.equalTo(self).multipliedBy(0.08);
        make.width.equalTo(self).multipliedBy(0.15);
        make.centerX.equalTo(self);
    }];
    [_imageView setImage:[UIImage imageNamed:@"笔组合.png"]];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView.mas_bottom);
        make.height.equalTo(self).multipliedBy(0.06);
        make.width.equalTo(self).multipliedBy(0.4);
        make.centerX.equalTo(self);
    }];
    _label.text = @"安康盛世也有冻死饿殍\n动荡乱世也有荣华富贵";
    _label.numberOfLines = 0;
    _label.font = [UIFont systemFontOfSize:12];
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    
    _accountTextField.backgroundColor = [UIColor whiteColor];
    [_accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(self.frame.size.height*0.36);
        make.height.equalTo(self).multipliedBy(0.06);
        make.width.equalTo(self).multipliedBy(0.7);
        make.centerX.equalTo(self);
    }];
    _accountTextField.placeholder = @"请求输入账号";
    [self setTextField:_accountTextField];
    
    _passwardTextField.backgroundColor = [UIColor whiteColor];
    [_passwardTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_accountTextField.mas_bottom).offset(self.frame.size.height*0.02);
        make.height.equalTo(_accountTextField);
        make.left.and.right.equalTo(_accountTextField);
    }];
    _passwardTextField.placeholder = @"请输入密码";
    _passwardTextField.secureTextEntry = YES;
    [self setTextField:_passwardTextField];
    
    _signinButton.backgroundColor = [UIColor colorWithRed:0.15 green:0.65 blue:0.6 alpha:1.00];
    [_signinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwardTextField.mas_bottom).offset(self.frame.size.height*0.05);
        make.height.equalTo(_accountTextField).multipliedBy(0.9);
        make.width.equalTo(self).multipliedBy(0.65);
        make.centerX.equalTo(self);
    }];
    [_signinButton setTitle:@"登录" forState:UIControlStateNormal];
//    _signinButton.layer.cornerRadius = 18;
//    _signinButton.layer.masksToBounds = YES;
    [_signinButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    
    [_signupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_signinButton.mas_bottom).offset(self.frame.size.height*0.025);
        make.height.equalTo(self).multipliedBy(0.03);
        make.left.equalTo(_signinButton);
        make.width.equalTo(self).multipliedBy(0.1);
    }];
    [_signupButton setTitle:@"注册" forState:UIControlStateNormal];
    [_signupButton.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [_signupButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_findPasswradButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(_signupButton);
        make.right.equalTo(_signinButton);
        make.width.equalTo(self).multipliedBy(0.2);
    }];
    [_findPasswradButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [_findPasswradButton.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [_findPasswradButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)setTextField:(UITextField *)textField{
    textField.backgroundColor = [UIColor clearColor];
    [textField setFont:[UIFont systemFontOfSize:15]];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_passwardTextField resignFirstResponder];
    [_accountTextField resignFirstResponder];
}

- (void)drawRect:(CGRect)rect{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    UIColor *color = [UIColor colorWithRed:0.15 green:0.65 blue:0.6 alpha:1.00];
    [color set];
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapButt;
    [path moveToPoint:CGPointMake(0, height*0.3)];
    [path addQuadCurveToPoint:CGPointMake(width, height*0.3) controlPoint:CGPointMake(width*0.5, height*0.3+30)];
    [path addLineToPoint:CGPointMake(width, 0)];
    [path addLineToPoint:CGPointMake(0, 0)];
    [path closePath];
    [path fill];
    
    UIColor *color1 = [UIColor lightGrayColor];
    [color1 set];
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    path1.lineWidth = 2.0;
    path1.lineJoinStyle = kCGLineCapButt;
    [path1 moveToPoint:CGPointMake(width*0.15, height*0.42)];
    [path1 addLineToPoint:CGPointMake(width*0.85, height*0.42)];
    [path1 stroke];
    
    [path1 moveToPoint:CGPointMake(width*0.15, height*0.50)];
    [path1 addLineToPoint:CGPointMake(width*0.85, height*0.50)];
    [path1 stroke];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
