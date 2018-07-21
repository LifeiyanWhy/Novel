//
//  NOVChatroomView.h
//  小说
//
//  Created by 李飞艳 on 2018/5/3.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NOVChatroomView : UIView<UITextViewDelegate>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UIView *inputView;

@property(nonatomic,strong) UITextView *textView;

@property(nonatomic,strong) UIButton *sendButton;

//@property(nonatomic,strong) UIButton *expressionButton;

- (void)textViewShow:(CGRect)keyboardframe;

- (void)textViewHide:(CGRect)keyboardframe;

- (void)sendmessageWithIndexPath:(NSIndexPath *)indexPath;

@end
