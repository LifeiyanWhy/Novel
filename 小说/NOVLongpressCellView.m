//
//  NOVLongpressCellView.m
//  小说
//
//  Created by 李飞艳 on 2018/5/17.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVLongpressCellView.h"
#import "Masonry.h"

@implementation NOVLongpressCellView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.layer.shadowOpacity = 0.8f;
        self.layer.shadowOffset = CGSizeMake(-2, 3);
        self.layer.shadowRadius = 4.0f;
        self.layer.masksToBounds = NO;
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_deleteButton];
        
        _settopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_settopButton];
    }
    return self;
}

-(void)layoutSubviews{
    
    _settopButton.backgroundColor = [UIColor whiteColor];
    [_settopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.height.equalTo(self).multipliedBy(0.5);
        make.left.and.right.equalTo(self);
    }];
    [_settopButton setTitle:@"消息置顶" forState:UIControlStateNormal];
    [_settopButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _settopButton.titleLabel.font = [UIFont systemFontOfSize:13];
    
    _deleteButton.backgroundColor = [UIColor whiteColor];
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_settopButton.mas_bottom);
        make.left.and.right.equalTo(_settopButton);
        make.bottom.equalTo(self);
    }];
    [_deleteButton setTitle:@"删除该对话" forState:UIControlStateNormal];
    [_deleteButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _deleteButton.titleLabel.font = [UIFont systemFontOfSize:13];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
