//
//  NOVFindView.m
//  小说
//
//  Created by 李飞艳 on 2018/4/12.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVFindView.h"

#define Width self.frame.size.width
#define Height self.frame.size.height

@implementation NOVFindView{
    UILabel *rightLabel;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

-(void)addUI{
    self.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    
    _headView = [[NOVView alloc] initWithFrame:CGRectMake(0, 0, Width * 0.75, Height * 0.11) titleArray:[NSArray arrayWithObjects:@"今日推介",@"排行榜",@"全部作品", nil]];
    _headView.backgroundColor = [UIColor  colorWithRed:0.15 green:0.65 blue:0.60 alpha:1.00];
    [self addSubview:_headView];
    
    rightLabel = [[UILabel alloc] init];
    [self addSubview:rightLabel];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headView.mas_right).offset(-1);
        make.right.equalTo(self);
        make.top.and.bottom.equalTo(_headView);
    }];
    rightLabel.backgroundColor = [UIColor colorWithRed:0.15 green:0.65 blue:0.60 alpha:1.00];
    
//    _myStartButton = [[UIButton alloc] init];
//    [self addSubview:_myStartButton];
//    [_myStartButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self).offset(-10);
//        make.width.equalTo(self).multipliedBy(0.15f);
//        make.bottom.equalTo(_headView).offset(-5);
//        make.height.equalTo(_headView).multipliedBy(0.35f);
//    }];
//    [_myStartButton setTitle:@"我要发起" forState:UIControlStateNormal];
//    [_myStartButton.titleLabel setFont:[UIFont systemFontOfSize:11]];
//    [_myStartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    _myStartButton.layer.cornerRadius = 5;
//    _myStartButton.layer.borderWidth = 1.5;
//    _myStartButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.frame.size.height*0.11, Width , Height*0.89)];
    [self addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(Width*3,Height*0.89);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.directionalLockEnabled = YES;
    
   
    _todayPromotionView = [[NOVFindBottomView alloc] init];
    _rankingListView = [[NOVFindBottomView alloc] init];
    _allWorksView = [[NOVFindBottomView alloc] init];
    NSArray *array = [NSArray arrayWithObjects:_todayPromotionView,_rankingListView,_allWorksView, nil];
    for (int i = 0; i < array.count; i++) {
        [_scrollView addSubview:array[i]];
        [array[i] setFrame:CGRectMake(Width*i, 0, Width, Height*0.89)];
    }
}

-(void)viewResponseWhenTouchButton:(UIButton *)button{
    NSLog(@"touchButton:%@",button.titleLabel.text);
    NSInteger i = button.tag;
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width*i, 0) animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
