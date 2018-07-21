//
//  NOVFindView.h
//  小说
//
//  Created by 李飞艳 on 2018/4/12.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NOVView.h"
#import "Masonry.h"
#import "NOVFindBottomView.h"

@interface NOVFindView : UIView

//@property(nonatomic,strong) UIButton *myStartButton;

@property(nonatomic,strong) UIScrollView *scrollView;

@property(nonatomic,strong) NOVView *headView;

//今日推介
@property(nonatomic,strong) NOVFindBottomView *todayPromotionView;
//排行榜
@property(nonatomic,strong) NOVFindBottomView *rankingListView;
//全部作品
@property(nonatomic,strong) NOVFindBottomView *allWorksView;

-(instancetype)initWithFrame:(CGRect)frame;

-(void)viewResponseWhenTouchButton:(UIButton *)button;

@end
