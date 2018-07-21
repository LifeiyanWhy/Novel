//
//  NOVKeyboardView.m
//  小说
//
//  Created by 李飞艳 on 2018/6/21.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVKeyboardView.h"
#import "Masonry.h"

@implementation NOVKeyboardView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        _hiddenKeyboard = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_hiddenKeyboard];
    }
    return self;
}

-(void)layoutSubviews{
    self.backgroundColor = [UIColor whiteColor];
    
    [_hiddenKeyboard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self).multipliedBy(0.8);
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-10);
        make.width.equalTo(self).multipliedBy(0.1f);
    }];
    [_hiddenKeyboard setImage:[UIImage imageNamed:@"下拉.png"] forState:UIControlStateNormal];
}

-(void)drawRect:(CGRect)rect{
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
