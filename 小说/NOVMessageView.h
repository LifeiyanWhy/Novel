//
//  NOVMessageView.h
//  小说
//
//  Created by 李飞艳 on 2018/4/19.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NOVView.h"

@class NOVLongpressCellView;

@interface NOVMessageView : UIView

@property(nonatomic,strong) NOVView *headView;

@property(nonatomic,strong) UIButton *leftButton;

@property(nonatomic,strong) UIButton *rightButton;

@property(nonatomic,strong) UIScrollView *scrollView;

@property(nonatomic,strong) UITableView *noticeTableView;

@property(nonatomic,strong) UITableView *chatTableView;

@property(nonatomic,strong) NOVLongpressCellView *longPressView;

-(instancetype)initWithFrame:(CGRect)frame;

//-(void)viewResponseWhenTouchScrollView:(UIScrollView *)scrollView;

-(void)viewResponseWhenTouchButton:(UIButton *)button;

-(void)longPress:(CGPoint)pressPoint;

//让长按显示的view消失
-(void)longPressViewTakeUp;

@end
