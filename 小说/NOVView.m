//
//  NOVView.m
//  小说
//
//  Created by 李飞艳 on 2018/4/10.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVView.h"
#import "Masonry.h"

#define Width self.frame.size.width
#define Height self.frame.size.height

@implementation NOVView{
    //存放button的数组
    NSMutableArray *buttonArray;
    UIButton *currentButton;
    UIView *slideView;
}
-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray{
    self = [super initWithFrame:frame];
    if (self) {
        _titleArray = titleArray;
        [self addUI];
    }
    return self;
}

-(void)addUI{
    //计算button的宽度
    float buttonWidth = Width*1.0/_titleArray.count;
    //记录当前(选中)button
    currentButton = [[UIButton alloc] init];
    
    
    buttonArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < _titleArray.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * buttonWidth, 0, buttonWidth , Height)];
        [self addSubview:button];
        button.tag = i;
        button.backgroundColor = self.backgroundColor;
        if (i == 0) {
            button.selected = YES;
            currentButton = button;
        }
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.00] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightMedium]];
        [button setContentEdgeInsets:UIEdgeInsetsMake(20, 0, 0, 0)];
        [buttonArray addObject:button];
        //给button添加点击事件，点击时状态切换
        [button addTarget:self action:@selector(buttonResponse:) forControlEvents:UIControlEventTouchUpInside];
    }

    
    slideView = [[UIView alloc] init];
    slideView.backgroundColor = [UIColor whiteColor];
    [self addSubview:slideView];
    [slideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(currentButton);
        make.right.equalTo(currentButton.mas_right);
        make.bottom.equalTo(currentButton);
        make.height.equalTo(currentButton).multipliedBy(0.03f);
    }];
    if (buttonArray.count > 0) {
        currentButton = buttonArray[0];
    }
}

-(void)buttonResponse:(UIButton *)button{
    
    currentButton.selected = NO;
    //被点击的button改变状态
    button.selected = YES;
    currentButton = button;
    
    //滑动view改变位置
    [slideView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(currentButton);
        make.right.equalTo(currentButton);
        make.bottom.equalTo(currentButton);
        make.height.equalTo(currentButton).multipliedBy(0.03f);
    }];
    //执行代理方法
    if ([_delegate respondsToSelector:@selector(touchRespone:)]) {
        [self.delegate touchRespone:currentButton];
    }
}

-(void)setTitleArray:(NSArray *)titleArray{
    self.titleArray = titleArray;
}

-(void)setTitleColor:(UIColor *)titleColor selectedColor:(UIColor *)selectedColor{
    for (UIButton *Button in buttonArray) {
        [Button setTitleColor:titleColor forState:UIControlStateNormal];
        [Button setTitleColor:selectedColor forState:UIControlStateSelected];
        slideView.backgroundColor = selectedColor;
    }
}

-(void)setButtonPostion:(CGPoint)point width:(CGFloat)width{
    CGFloat offset = point.x*self.frame.size.width/width;
    CGFloat buttonWidth = self.frame.size.width/buttonArray.count;
    [slideView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(offset);
        make.width.equalTo(currentButton);
        make.bottom.equalTo(currentButton);
        make.height.equalTo(currentButton).multipliedBy(0.03f);
    }];
    if (currentButton.tag != (int)offset/buttonWidth) {
        currentButton.selected = NO;
        currentButton = buttonArray[(int)(offset/buttonWidth)];
        currentButton.selected = YES;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end
