//
//  SJView.h
//  小说
//
//  Created by 李飞艳 on 2018/3/30.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJBottomView.h"

@class NOVView;

@interface SJView : UIView

@property(nonatomic,strong) NOVView *headView;

@property(nonatomic,strong) UIScrollView *scrollView;

@property(nonatomic,strong) SJBottomView *collectionView;

@property(nonatomic,strong) SJBottomView *followView;

@property(nonatomic,strong) SJBottomView *joinView;

@property(nonatomic,strong) SJBottomView *currentView;

//我要发起
@property(nonatomic,strong) UIButton *startButton;

-(void)viewResponseWhenTouchButton:(UIButton *)button;

@end
