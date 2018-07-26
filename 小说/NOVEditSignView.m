//
//  NOVEditSignView.m
//  小说
//
//  Created by 李飞艳 on 2018/7/26.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVEditSignView.h"

@implementation NOVEditSignView{
    UILabel *label;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _textView = [[UITextView alloc] init];
        [self addSubview:_textView];
        
        _wordNumberLabel = [[UILabel alloc] init];
        [self addSubview:_wordNumberLabel];
        
        label = [[UILabel alloc] init];
        [self addSubview:label];
        
        self.placeholder = @"一句话介绍自己";
    }
    return self;
}

-(void)layoutSubviews{
    self.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    _textView.backgroundColor = [UIColor whiteColor];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self);
        make.height.equalTo(self).multipliedBy(0.3f);
    }];
    [_textView setFont:[UIFont systemFontOfSize:15]];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_textView.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_textView.text length])];
    _textView.attributedText = attributedString;
    _textView.text = self.placeholder;
    _textView.textColor = [UIColor grayColor];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textView.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.right.equalTo(self).offset(-10);
        make.width.mas_equalTo(30);
    }];
    [label setFont:[UIFont systemFontOfSize:12]];
    [label setTextColor:[UIColor blackColor]];
    label.text = @"/100";
    label.textAlignment = NSTextAlignmentLeft;
    
    [_wordNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.width.equalTo(label);
        make.right.equalTo(label.mas_left);
    }];
    [_wordNumberLabel setFont:[UIFont systemFontOfSize:12]];
    [_wordNumberLabel setTextColor:[UIColor blackColor]];
    _wordNumberLabel.text = @"0";
    _wordNumberLabel.textAlignment = NSTextAlignmentRight;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textView resignFirstResponder];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
