//
//  SJView.m
//  小说
//
//  Created by 李飞艳 on 2018/3/30.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "SJView.h"
#import "NOVView.h"
#define Width self.frame.size.width
#define Height self.frame.size.height

@implementation SJView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    self.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    
    _headView = [[NOVView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width*0.66, 64) titleArray:@[@"我的关注",@"我的收藏",@"我的参与"]];
    _headView.backgroundColor = [UIColor  colorWithRed:0.15 green:0.65 blue:0.60 alpha:1.00];
    [self addSubview:_headView];
    
    _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _startButton.frame = CGRectMake(self.frame.size.width*0.8, 64*0.6, self.frame.size.width*0.15, 64*0.35);
    [self addSubview:_startButton];
    [_startButton setTitle:@"我的发起" forState:UIControlStateNormal];
    [_startButton.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [_startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _startButton.layer.cornerRadius = 5;
    _startButton.layer.borderWidth = 1.5;
    _startButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Width , Height - 64)];
    [self addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(Width*3,Height - 64);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.directionalLockEnabled = YES;
    
    _collectionView = [[SJBottomView alloc] init];
    _followView = [[SJBottomView alloc] init];
    _joinView = [[SJBottomView alloc] init];
    
    NSArray *array = [NSArray arrayWithObjects:_followView,_collectionView,_joinView, nil];
    for (int i = 0; i < array.count; i++) {
        [_scrollView addSubview:array[i]];
        [array[i] setFrame:CGRectMake(Width*i, 0, Width, Height - 64)];
    }
}

-(void)viewResponseWhenTouchButton:(UIButton *)button{
    NSLog(@"touchButton:%@",button.titleLabel.text);
    NSInteger i = button.tag;
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width*i, 0) animated:YES];
}

-(void)drawRect:(CGRect)rect{
    UIColor *color = [UIColor colorWithRed:0.15 green:0.65 blue:0.60 alpha:1.00];
    [color set];

    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, 0)];
    [bezierPath addLineToPoint:CGPointMake(0, 64)];
    [bezierPath addLineToPoint:CGPointMake(self.frame.size.width, 64)];
    [bezierPath addLineToPoint:CGPointMake(self.frame.size.width, 0)];
    [bezierPath closePath];
    [bezierPath fill];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
