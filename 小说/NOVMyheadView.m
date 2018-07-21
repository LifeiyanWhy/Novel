//
//  NOVMyheadView.m
//  小说
//
//  Created by 李飞艳 on 2018/5/8.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVMyheadView.h"
#import "Masonry.h"
#import "NOVHeadView.h"

@implementation NOVMyheadView{
    CGFloat viewheight;
}

-(instancetype)initWithFrame:(CGRect)frame Size:(CGSize)size{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"%f",size.height);
        viewheight = size.height;
        
        _myImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_myImageButton];
        
        _nameLabel = [[UILabel alloc] init];
        [self addSubview:_nameLabel];
        
        _profileLabel = [[UILabel alloc] init];
        [self addSubview:_profileLabel];
        
        _myworkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_myworkButton];
        
        _myfollowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_myfollowButton];
        
        _myfansButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_myfansButton];
        
    }
    return self;
}

-(void)layoutSubviews{
    self.backgroundColor = [UIColor redColor];
    [_myImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(viewheight*0.08);
        make.height.mas_equalTo(viewheight*0.08);
        make.width.equalTo(self).multipliedBy(0.15);
        make.centerX.equalTo(self);
    }];
    _myImageButton.layer.cornerRadius = 25;
    _myImageButton.layer.masksToBounds = YES;
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_myImageButton.mas_bottom).offset(5);
        make.height.mas_equalTo(viewheight*0.04);
        make.width.equalTo(self).multipliedBy(0.3);
        make.centerX.equalTo(self);
    }];
    _nameLabel.text = @"劝你善良";
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.font = [UIFont systemFontOfSize:16];
    
    [_profileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom);
        make.height.equalTo(_nameLabel);
        make.width.equalTo(self).multipliedBy(0.5);
        make.centerX.equalTo(self);
    }];
    _profileLabel.text = @"简介:新时代优秀大学生";
    _profileLabel.textColor = [UIColor whiteColor];
    _profileLabel.textAlignment = NSTextAlignmentCenter;
    _profileLabel.font = [UIFont systemFontOfSize:12];
    
    
    [_myworkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(viewheight*0.35);
        make.height.mas_equalTo(viewheight*0.08);
        make.left.equalTo(self).offset(self.frame.size.width*0.12);
        make.width.equalTo(self).multipliedBy(0.25);
    }];
    [_myworkButton setImage:[UIImage imageNamed:@"作品.png"] forState:UIControlStateNormal];
    [self setButton:_myworkButton withTitle:@"我的作品"];
    
    [_myfollowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.height.and.width.equalTo(_myworkButton);
        make.left.equalTo(_myworkButton.mas_right).offset(self.frame.size.width*0.05);
    }];
    [_myfollowButton setImage:[UIImage imageNamed:@"关注.png"] forState:UIControlStateNormal];
    [self setButton:_myfollowButton withTitle:@"我的关注"];
    
    [_myfansButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.height.and.width.equalTo(_myworkButton);
        make.left.equalTo(_myfollowButton.mas_right).offset(self.frame.size.width*0.05);
    }];
    [_myfansButton setImage:[UIImage imageNamed:@"粉丝.png"] forState:UIControlStateNormal];
    [self setButton:_myfansButton withTitle:@"我的粉丝"];

}

- (void)setButton:(UIButton *)button withTitle:(NSString *)title{
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    CGFloat labelHeight = button.titleLabel.intrinsicContentSize.height;
    CGFloat imageHeight = button.imageView.intrinsicContentSize.height;
    CGFloat labelWidth = button.imageView.intrinsicContentSize.width;
    [button setImageEdgeInsets:UIEdgeInsetsMake(labelHeight*-1, 0,labelHeight, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(imageHeight/2, labelWidth*-1-10, -1*imageHeight/2, labelWidth+10)];
}

- (void)drawRect:(CGRect)rect{
    CGFloat width = self.frame.size.width;
    CGFloat height = viewheight;
    UIColor *color = [UIColor colorWithRed:0.15 green:0.65 blue:0.6 alpha:1.00];
    [color set];
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapButt;
    [path moveToPoint:CGPointMake(0, height*0.3)];
    [path addQuadCurveToPoint:CGPointMake(width, height*0.3) controlPoint:CGPointMake(width*0.5, height*0.3 + 30)];
    [path addLineToPoint:CGPointMake(width, 0)];
    [path addLineToPoint:CGPointMake(0, 0)];
    [path closePath];
    [path fill];
    
    UIColor *color1 = [UIColor whiteColor];
    [color1 set];
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    path1.lineWidth = 2;
    path1.lineCapStyle = kCGLineCapRound;
    path1.lineJoinStyle = kCGLineCapButt;
    [path1 moveToPoint:CGPointMake(0, height*0.3)];
    [path1 addQuadCurveToPoint:CGPointMake(width, height*0.3) controlPoint:CGPointMake(width*0.5, height*0.3 + 30)];
    [path1 addLineToPoint:CGPointMake(width, height*0.43)];
    [path1 addLineToPoint:CGPointMake(0, height*0.43)];
    [path1 closePath];
    [path1 fill];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
