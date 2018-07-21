//
//  NOVReadNovelView.m
//  小说
//
//  Created by 李飞艳 on 2018/4/21.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVReadNovelView.h"
#import "Masonry.h"
#import "NOVReadEditVIew.h"

@implementation NOVReadNovelView{
    UIView *contentView;
    UIView *bottomContentView;
    BOOL content;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    bottomContentView = [[UIView alloc] init];
    [self addSubview:bottomContentView];
    bottomContentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"novelBackground.png"]];
    [bottomContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    contentView = [[UIView alloc] init];
    [self addSubview:contentView];
    contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"novelBackground.png"]];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    _contentLabel = [[UILabel alloc] init];
    [contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(20);
        make.left.equalTo(contentView).offset(10);
        make.right.equalTo(contentView).offset(-10);
    }];
    _contentLabel.numberOfLines = 0;
    [_contentLabel sizeToFit];
    
    
    _midButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_midButton];
    [_midButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self).multipliedBy(0.5);
        make.height.equalTo(self).multipliedBy(0.5);
        make.center.equalTo(self);
    }];
}

- (void)setMenu:(NOVReadEditVIew *)view{
    _midButton.selected = !_midButton.selected;
    if (_midButton.selected) {
        [self displayMenu:view];
    } else{
        if (view.rightButton.selected) {
            [view touchRightButtonCollection:NO follow:NO];
        }
        [self hiddenMenu:view];
    }
}

- (void)displayMenu:(NOVReadEditVIew *)view{
    [self addSubview:view];
    view.backgroundColor = [UIColor clearColor];
    [UIView transitionWithView:view duration:0.2 options:UIViewAnimationOptionTransitionNone animations:^{
        view.alpha = 1;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    } completion:^(BOOL finished) {
    }];
}

- (void)hiddenMenu:(NOVReadEditVIew *)view{
        [UIView transitionWithView:view duration:0.2 options:UIViewAnimationOptionTransitionNone  animations:^{
            view.alpha = 0;
        } completion:^(BOOL finished) {
        }];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
////    _isEdit = !_isEdit;
////    if (_isEdit) {
////        NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
////        UITouch *touch = [allTouches anyObject];   //视图中的所有对象
////        CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
////        CGFloat width = [UIScreen mainScreen].bounds.size.width;
////        CGFloat height = [UIScreen mainScreen].bounds.size.height;
////        NSLog(@"%f %f %f %f",point.x,point.y,width,height);
////        if (point.x >= width*0.25 && point.x <= width*0.75 && point.y >= height*0.25 && point.y <= height*0.75 ) {
////            NSLog(@"%f %f %f %f",point.x,point.y,width,height);
////            [self displayMenu];
////        }
////    }else{
////        [self hideMenu];
////    }
//    if (_midButton.selected) {
//        [self hideMenu];
//        _midButton.selected = NO;
//    }
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
