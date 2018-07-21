//
//  NOVChatroomView.m
//  小说
//
//  Created by 李飞艳 on 2018/5/3.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVChatroomView.h"
#import "Masonry.h"

@implementation NOVChatroomView{
    //记录键盘位置
    CGRect keyBoardframe;
    //文本View的高度
    CGFloat inputViewHeight;
    
    NSIndexPath *_indexPath;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc] init];
        [self addSubview:_tableView];
        
        _inputView = [[UIView alloc] init];
        [self addSubview:_inputView];
        
        _textView = [[UITextView alloc] init];
        [_inputView addSubview:_textView];
        
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_inputView addSubview:_sendButton];
        
        UIImageView *image = [[UIImageView alloc] init];
        image.backgroundColor = [UIColor grayColor];
        [_inputView addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.top.equalTo(_inputView);
            make.height.mas_equalTo(0.5);
        }];
        
        _inputView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
        [_inputView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(40);
        }];
        inputViewHeight = 40;
        
        _textView.backgroundColor = [UIColor whiteColor];
        [_textView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_inputView).offset(self.frame.size.width*0.04);
            make.width.equalTo(_inputView).multipliedBy(0.85f);
            make.top.equalTo(_inputView).offset(4);
            make.bottom.equalTo(_inputView).offset(-4);
            make.centerY.equalTo(_inputView);
        }];
        _textView.delegate = self;
        _textView.layer.borderWidth = 0.5;
        _textView.layer.borderColor = [UIColor grayColor].CGColor;
        _textView.layer.cornerRadius = 5;
        _textView.layer.masksToBounds = YES;
        
        [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_textView).offset(2);
            make.height.mas_equalTo(self.frame.size.width*0.07);
            make.width.equalTo(_inputView).multipliedBy(0.07f);
            make.right.equalTo(_inputView).offset(-5);
        }];
        [_sendButton setImage:[UIImage imageNamed:@"发送.png"] forState:UIControlStateNormal];
    }
    return self;
}

-(void)layoutSubviews{
//    NSLog(@"chatroomViewlayoutsubviews%f",self.frame.size.height);
    self.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.equalTo(_inputView.mas_top);
        make.left.and.right.equalTo(self);
    }];
    _tableView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    _tableView.tableFooterView = [[UIView alloc] init];
    //滑动时隐藏键盘
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    //给tableview添加手势，用于回收键盘
    [_tableView addGestureRecognizer:tap];
    [tap addTarget:self action:@selector(touchTableview)];
}

- (void)textViewShow:(CGRect)keyboardframe{
    keyBoardframe = keyboardframe;
    [_inputView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.bottom.equalTo(self).offset(keyBoardframe.size.height*-1);
        make.height.mas_equalTo(inputViewHeight);
    }];
}

- (void)textViewHide:(CGRect)keyboardframe{
    keyBoardframe = CGRectZero;
    [_inputView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(inputViewHeight);
    }];
}

- (void)touchTableview{
    [_textView resignFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView{
    //计算当前高度
    CGFloat height = [_textView sizeThatFits:CGSizeMake(self.frame.size.width*0.85, MAXFLOAT)].height;
    if (height > 100) {
        height = 100;
    }
    //文本框的初始高度
    if (height >= 30) {
        [_inputView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self);
            make.bottom.equalTo(self).offset(keyBoardframe.size.height*-1);
            //比文本框上下各多4
            make.height.mas_equalTo(height+8);
        }];
    }
    inputViewHeight = height + 8;
}

- (void)sendmessageWithIndexPath:(NSIndexPath *)indexPath{
    //消息发送后清空输入框，调用代理方法
    _indexPath = indexPath;
    _textView.text = @"";
    [self textViewDidChange:_textView];
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
