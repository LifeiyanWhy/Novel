//
//  NOVWriteView.h
//  小说
//
//  Created by 李飞艳 on 2018/4/22.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NOVSetUpView;

@class NOVKeyboardView;

@protocol NOVWriteViewDelegate <NSObject>

@optional

//内容文本框中内容改变时执行该方法
- (void)contentTextViewChange:(NSUInteger)numberOfWords withContent:(NSString *)content;



@end

@interface NOVWriteView : UIView<UITextViewDelegate>

@property(nonatomic,weak) id <NOVWriteViewDelegate>delagate;

//输入简介的文本框
@property(nonatomic,strong) UITextView *titleTextView;

//显示章节
@property(nonatomic,strong) UILabel *chapterLabel;

//输入内容的文本框
@property(nonatomic,strong) UITextView *contentTextView;

@property(nonatomic,strong) UIButton *deleteButton;

@property(nonatomic,strong) UIButton *setupButton;

@property(nonatomic,strong) UIButton *writeButton;

@property(nonatomic,strong) UIButton *historyButton;

@property(nonatomic,strong) UIScrollView *scrollView;

@property(nonatomic,strong) NOVSetUpView *setUpView;

@property(nonatomic,strong) NOVKeyboardView *keyboardView;

//显示设置view
- (void)setupView;

//点击view
- (void)responseWhenTouchView;

//设置背景颜色
- (void)setViewColorWithColor:(UIColor *)color;

- (void)keyboardShowWithFrame:(CGRect)keyboardFrame;

- (void)keyBoardHidden;

@end
