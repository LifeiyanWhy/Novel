//
//  NOVMessageView.m
//  小说
//
//  Created by 李飞艳 on 2018/4/19.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVMessageView.h"
#import "Masonry.h"
#import "NOVLongpressCellView.h"

@implementation NOVMessageView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUIView];
        _longPressView = [[NOVLongpressCellView alloc] init];
        [self addSubview:_longPressView];
    }
    return self;
}

- (void)addUIView{
    self.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*0.11)];
    label.backgroundColor = [UIColor colorWithRed:0.15 green:0.65 blue:0.60 alpha:1.00];
    [self addSubview:label];

    _headView = [[NOVView alloc] initWithFrame:CGRectMake(self.frame.size.width*0.3, 0, self.frame.size.width*0.4, 64) titleArray:[NSArray arrayWithObjects:@"通知",@"聊天", nil]];
    _headView.backgroundColor = [UIColor  colorWithRed:0.15 green:0.65 blue:0.60 alpha:1.00];
    [self addSubview:_headView];
    
    _leftButton = [[UIButton alloc] init];
    [self addSubview:_leftButton];
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label);
        make.bottom.equalTo(label);
        make.height.and.width.mas_equalTo(self.frame.size.width*0.1);
    }];
    [_leftButton setImage:[UIImage imageNamed:@"添加.png"] forState:UIControlStateNormal];
    
    _rightButton = [[UIButton alloc] init];
    [self addSubview:_rightButton];
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(label).offset(-5);
        make.bottom.equalTo(label).offset(-5);
        make.height.and.width.mas_equalTo(self.frame.size.width*0.08);
    }];
    [_rightButton setImage:[UIImage imageNamed:@"聊天.png"] forState:UIControlStateNormal];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.frame.size.height*0.11, self.frame.size.width, self.frame.size.height*0.89)];
    [self addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(self.frame.size.width*2, self.frame.size.height*0.89);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.directionalLockEnabled = YES;
    
    _noticeTableView = [[UITableView alloc] init];
    _noticeTableView.showsVerticalScrollIndicator = NO;
    _noticeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    _chatTableView = [[UITableView alloc] init];
    _chatTableView.showsVerticalScrollIndicator = NO;
    _chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSArray *array = [NSArray arrayWithObjects:_noticeTableView,_chatTableView, nil];
    for (int i = 0; i < array.count; i++) {
        [_scrollView addSubview:array[i]];
        [array[i] setFrame:CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, self.frame.size.height*0.89)];
    }
    
}

//点击顶部button时执行
-(void)viewResponseWhenTouchButton:(UIButton *)button{
    NSLog(@"touchButton:%@",button.titleLabel.text);
    NSInteger i = button.tag;
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width*i, 0) animated:YES];
}

-(void)longPress:(CGPoint)pressPoint{
    CGFloat height = self.frame.size.height*0.13;
    CGFloat width = self.frame.size.width*0.3;
    
    //点击事件的坐标在view上的坐标
    CGFloat x = pressPoint.x;
    CGFloat y = pressPoint.y;
    if (x + width > self.frame.size.width && y + height > self.frame.size.height) {
        x -= width;
        y -= height;
    } else if (x + width > self.frame.size.width){
        x -= width;
    } else if (y + height > self.frame.size.height){
        y -= height;
    }
    [_longPressView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(y);
        make.height.mas_equalTo(height);
        make.left.mas_equalTo(x);
        make.width.mas_equalTo(width);
    }];
    _scrollView.userInteractionEnabled = NO;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self longPressViewTakeUp];
}

-(void)longPressViewTakeUp{
    [_longPressView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
        make.width.mas_equalTo(0);
    }];
    _scrollView.userInteractionEnabled = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
