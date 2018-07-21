//
//  NOVWriteView.m
//  小说
//
//  Created by 李飞艳 on 2018/4/22.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVWriteView.h"
#import "Masonry.h"
#import "NOVSetUpView.h"
#import "NOVKeyboardView.h"

@implementation NOVWriteView{
    UIView *view;
    NSArray *textPlacehoderArray;
    
    //记录设置view是否显示
    BOOL isSetupView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    self.backgroundColor = [UIColor whiteColor];
    
    textPlacehoderArray = [NSArray arrayWithObjects:@"请输入章节名称",@"请输入正文", nil];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*0.9)];
    [self addSubview:_scrollView];
    _scrollView.directionalLockEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    //作品简介输入框0.1H
    _titleTextView = [[UITextView alloc] init];
    [_scrollView addSubview:_titleTextView];
    _titleTextView.tag = 0;
    [_titleTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scrollView).offset(10);
        make.height.equalTo(self).multipliedBy(0.07f);
        make.width.equalTo(_scrollView).multipliedBy(0.94f);
        make.centerX.equalTo(_scrollView);
    }];
    [_titleTextView sizeToFit];
    _titleTextView.text = @"请输入章节名称";
    [_titleTextView setFont:[UIFont systemFontOfSize:18]];
    _titleTextView.textColor = [UIColor grayColor];
    _titleTextView.delegate = self;
    
    //正文输入框的生上面的label 0.05H
    _chapterLabel = [[UILabel alloc] init];
    [_scrollView addSubview:_chapterLabel];
    [_chapterLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleTextView.mas_bottom).offset(10);
        make.height.equalTo(self).multipliedBy(0.05);
        make.left.equalTo(_titleTextView);
        make.width.equalTo(self).multipliedBy(0.3f);
    }];
    _chapterLabel.text = @"📖 编辑内容";
    [_chapterLabel setFont:[UIFont systemFontOfSize:13]];
    _chapterLabel.textColor =  [UIColor grayColor];
    
    //正文输入框 0.85H-20
    _contentTextView = [[UITextView alloc] init];
    [_scrollView addSubview:_contentTextView];
    _contentTextView.tag = 1;
    [_contentTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_chapterLabel.mas_bottom);
        make.height.mas_equalTo(_scrollView.frame.size.height*0.85-20);
        make.right.and.left.equalTo(_titleTextView);
    }];
    [_contentTextView sizeToFit];
    _contentTextView.text = @"请输入正文";
    //设置行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_contentTextView.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_contentTextView.text length])];
    
    _contentTextView.attributedText = attributedString;
    [_contentTextView setFont:[UIFont systemFontOfSize:16]];
    _contentTextView.textColor = [UIColor grayColor];
    _contentTextView.delegate = self;
    _contentTextView.keyboardType = UIKeyboardTypeDefault;
    
    _deleteButton = [[UIButton alloc] init];
    [self addSubview:_deleteButton];
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(self.mas_height).multipliedBy(0.1);
        make.left.equalTo(self.mas_left).offset(self.frame.size.width*0.05);
        make.width.equalTo(self.mas_width).multipliedBy(0.15);
    }];
    [_deleteButton setImage:[UIImage imageNamed:@"删除.png"] forState:UIControlStateNormal];
    _deleteButton.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 10, 0);
    
    _setupButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_setupButton];
    [_setupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(_deleteButton);
        make.left.equalTo(_deleteButton.mas_right).offset(self.frame.size.width*0.1);
        make.width.equalTo(self).multipliedBy(0.15f);
    }];
    [_setupButton setImage:[UIImage imageNamed:@"设置-2.png"] forState:UIControlStateNormal];
    _setupButton.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 10, 0);
    
    _writeButton = [[UIButton alloc] init];
    [self addSubview:_writeButton];
    [_writeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(_deleteButton);
        make.left.equalTo(_setupButton.mas_right).offset(self.frame.size.width*0.1);
        make.width.equalTo(self).multipliedBy(0.15f);
    }];
    [_writeButton setImage:[UIImage imageNamed:@"写作.png"] forState:UIControlStateNormal];
    _writeButton.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 10, 0);
    
    _historyButton = [[UIButton alloc] init];
    [self addSubview:_historyButton];
    [_historyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(_deleteButton);
        make.left.equalTo(_writeButton.mas_right).offset(self.frame.size.width*0.1);
        make.width.equalTo(self).multipliedBy(0.15f);
    }];
    [_historyButton setImage:[UIImage imageNamed:@"历史记录.png"] forState:UIControlStateNormal];
    _historyButton.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 10, 0);
    
    UIImageView *imageview = [[UIImageView alloc] init];
    [self addSubview:imageview];
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentTextView);
        make.height.mas_equalTo(1);
        make.left.and.right.equalTo(_contentTextView);
    }];
    imageview.backgroundColor = [UIColor grayColor];
    
    UIImageView *bottomImageView = [[UIImageView alloc] init];
    [self addSubview:bottomImageView];
    [bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_deleteButton);
        make.height.mas_equalTo(1);
        make.left.and.right.equalTo(self);
    }];
    bottomImageView.backgroundColor = [UIColor grayColor];
    
    _setUpView = [[NOVSetUpView alloc] init];
    [self addSubview:_setUpView];
    
    _keyboardView = [[NOVKeyboardView alloc] init];
    [self addSubview:_keyboardView];
}

- (void)textViewDidChange:(UITextView *)textView{
/*
    //文本框的初始高度
    CGFloat contentHeight = _scrollView.frame.size.height*0.9-20;
    //计算当前高度
    CGFloat height = [_contentTextView sizeThatFits:CGSizeMake(self.frame.size.width*0.94, MAXFLOAT)].height;
    if (height > _scrollView.frame.size.height*0.85-20) {
        [_contentTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_chapterLabel.mas_bottom);
            make.height.mas_equalTo(height);
            make.right.and.left.equalTo(_titleTextView);
        }];
        _scrollView.scrollEnabled = YES;
        //height - contentHeight为文本框增加的高度
       _scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height*0.9 + height - contentHeight);
    }
 */
    //执行协议方法，参数为正文字数以及内容
    if(textView == _contentTextView){
        NSString *text = _contentTextView.text;
        [self.delagate contentTextViewChange:text.length withContent:text];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text  isEqual:textPlacehoderArray[textView.tag]]){
        textView.text = @"";
        [textView setTextColor:[UIColor blackColor]];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView.text  isEqual: @""]) {
        textView.text = textPlacehoderArray[textView.tag];
        [textView setTextColor:[UIColor grayColor]];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return YES;
}

- (void)setupView{
    //显示设置view
    _setUpView.backgroundColor = [UIColor whiteColor];
    [_setUpView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.and.right.equalTo(self);
        make.height.equalTo(self).multipliedBy(0.22f);
    }];
    //标记设置view(ssetUpView)为显示状态;
    isSetupView = YES;
    //取消scrollView与触摸事件的交互
    _scrollView.userInteractionEnabled = NO;
}


- (void)responseWhenTouchView{
    NSLog(@"touchView");
    //隐藏设置view
    if (isSetupView) {
        [_setUpView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(0);
        }];
        isSetupView = YES;
        _scrollView.userInteractionEnabled = YES;
    }
}

-(void)setViewColorWithColor:(UIColor *)color{
    _contentTextView.backgroundColor = color;
}

- (void)keyboardShowWithFrame:(CGRect)keyboardFrame{
    NSLog(@"%f %f %f %f",keyboardFrame.origin.x,keyboardFrame.origin.y,keyboardFrame.size.height,keyboardFrame.size.width);
    [_keyboardView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(keyboardFrame.size.height*-1 - 20);
        make.height.mas_equalTo(40);
        make.left.and.right.equalTo(self);
    }];
}

- (void)keyBoardHidden{
    [_keyboardView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.mas_equalTo(0);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
