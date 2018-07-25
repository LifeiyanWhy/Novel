//
//  NOVReadEditVIew.m
//  小说
//
//  Created by 李飞艳 on 2018/7/20.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVReadEditVIew.h"
#import "Masonry.h"

@implementation NOVReadEditVIew{
    UIView *topView;
    UIView *bottomView;
    UIView *rightView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        topView = [[UIView alloc] init];
        [self addSubview:topView];
        topView.backgroundColor = [UIColor blackColor];
        
        bottomView = [[UIView alloc] init];
        [self addSubview:bottomView];
        bottomView.backgroundColor = [UIColor blackColor];
        
        //rightView
        rightView = [[UIView alloc] init];
        rightView.backgroundColor = [UIColor blackColor];
        [self addSubview:rightView];
        
        _followButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightView addSubview:_followButton];
        [self setRightViewButton:_followButton imageTitle:@"关注本书"];
        
        _collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightView addSubview:_collectionButton];
        [self setRightViewButton:_collectionButton imageTitle:@"收藏本段"];
        
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightView addSubview:_commentButton];
        [self setRightViewButton:_commentButton imageTitle:@"评  论"];
        [self setRightButton:_commentButton Title:@"评  论"];
        
        _backButton = [[UIButton alloc] init];
        [topView addSubview:_backButton];
        
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [topView addSubview:_rightButton];
        
        _partButton = [[UIButton alloc] init];
        [topView addSubview:_partButton];
        
        _catalogButton = [[UIButton alloc] init];
        [bottomView addSubview:_catalogButton];
        
        _nightButton = [[UIButton alloc] init];
        [bottomView addSubview:_nightButton];
        
        _nextChapterButton = [[UIButton alloc] init];
        [bottomView addSubview:_nextChapterButton];
    }
    return self;
}

-(void)layoutSubviews{
    [topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.height.mas_equalTo(64);
        make.left.and.width.equalTo(self);
    }];
    
    [_backButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(topView).offset(-5);
        make.left.equalTo(topView).offset(5);
        make.width.and.height.equalTo(topView.mas_height).multipliedBy(0.5f);
    }];
    [_backButton setImage:[UIImage imageNamed:@"返回-3.png"] forState:UIControlStateNormal];
    
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView).offset(-5);
        make.bottom.equalTo(topView).offset(-5);
        make.width.and.height.equalTo(topView.mas_height).multipliedBy(0.3f);
    }];
    [_rightButton setImage:[UIImage imageNamed:@"点点.png"] forState:UIControlStateNormal];
    
    [_partButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(_rightButton);
        make.right.equalTo(_rightButton.mas_left).offset(-5);
        make.width.equalTo(topView).multipliedBy(0.18f);
    }];
    _partButton.backgroundColor = [UIColor colorWithRed:0.52 green:0.54 blue:0.59 alpha:1.00];
    _partButton.layer.cornerRadius = 10;
    _partButton.layer.masksToBounds = YES;
    [_partButton setTitle:@"本段说" forState:UIControlStateNormal];
    [_partButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_partButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_partButton setImage:[UIImage imageNamed:@"眼睛.png"] forState:UIControlStateNormal];
    
    [bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.mas_equalTo(64);
        make.left.and.width.equalTo(self);
    }];
    CGFloat labelWidth = _partButton.titleLabel.intrinsicContentSize.width;
    CGFloat imageWidth = _partButton.imageView.intrinsicContentSize.width;
    [_partButton setImageEdgeInsets:UIEdgeInsetsMake(0, labelWidth, 0, labelWidth*-1)];
    [_partButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -1*imageWidth - 5, 0, imageWidth + 5)];
    
    [_catalogButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView);
        make.left.equalTo(bottomView).offset(10);
        make.height.and.width.equalTo(bottomView.mas_height);
    }];
    [_catalogButton setImage:[UIImage imageNamed:@"目录.png"] forState:UIControlStateNormal];
    [self setButton:_catalogButton withTitle:@"阅读记录"];
    
    [_nightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.width.equalTo(_catalogButton);
        make.centerX.equalTo(self);
    }];
    [_nightButton setImage:[UIImage imageNamed:@"夜间readview.png"] forState:UIControlStateNormal];
    [self setButton:_nightButton withTitle:@"夜间"];
    
    [_nextChapterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.width.equalTo(_catalogButton);
        make.right.equalTo(self).offset(-10);
    }];
    [_nextChapterButton setImage:[UIImage imageNamed:@"下一章.png"] forState:UIControlStateNormal];
    [self setButton:_nextChapterButton withTitle:@"下一章"];
}

- (void)touchRightButtonCollection:(BOOL)collection follow:(BOOL)follow{
    NSLog(@"rightView");
    if (!_rightButton.selected) {
        if (follow) {
            [self setRightButton:_followButton Title:@"已关注"];
            _followButton.selected = YES;
        } else {
            [self setRightButton:_followButton Title:@"关注本书"];
            _followButton.selected = NO;
        }
        if (collection) {
            [self setRightButton:_collectionButton Title:@"已收藏"];
            _collectionButton.selected = YES;
        } else {
            [self setRightButton:_collectionButton Title:@"收藏本段"];
            _collectionButton.selected = NO;
        }
        rightView.alpha = 1;
        [UIView transitionWithView:rightView duration:0.4 options:UIViewAnimationOptionTransitionFlipFromTop  animations:^{
            [rightView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).offset(-10);
                make.width.equalTo(self).multipliedBy(0.25);
                make.top.equalTo(self).offset(64+10);
                make.height.equalTo(self).multipliedBy(0.15);
            }];
        } completion:^(BOOL finished) {
        }];
        
        [_collectionButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(rightView).multipliedBy(0.9);
            make.centerX.equalTo(rightView);
            make.top.equalTo(rightView);
            make.height.equalTo(rightView).multipliedBy(1.0/3);
        }];
        
        [_followButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.height.equalTo(_collectionButton);
            make.top.equalTo(_collectionButton.mas_bottom);
        }];
        
        [_commentButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.height.equalTo(_collectionButton);
            make.top.equalTo(_followButton.mas_bottom);
        }];
        _rightButton.selected = YES;
    } else{
        [UIView transitionWithView:rightView duration:0.3 options:UIViewAnimationOptionTransitionFlipFromBottom  animations:^{
            rightView.alpha = 0;
        } completion:^(BOOL finished) {
        }];
        _rightButton.selected = NO;
    }
}

- (void)collectionButtonChange:(UIButton *)button{
    if (button.selected) {     //收藏或取消收藏成功该改变button状态
        [self setRightButton:_collectionButton Title:@"收藏本段"];
        button.selected = !button.selected;
    }else{
        [self setRightButton:_collectionButton Title:@"已收藏"];
        button.selected = !button.selected;
    }
}

- (void)followButtonChange:(UIButton *)button{
    if (button.selected) {  //关注或取关成功改变followButton状状态
        [self setRightButton:_followButton Title:@"关注本书"];
        button.selected = !button.selected;
    }else{
        [self setRightButton:_followButton Title:@"已关注"];
        button.selected = !button.selected;
    }
}

- (void)setButton:(UIButton *)button withTitle:(NSString *)title{
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.52 green:0.54 blue:0.59 alpha:1.00] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
    CGFloat labelWidth = button.titleLabel.intrinsicContentSize.width;
    CGFloat imageWidth = button.imageView.intrinsicContentSize.width;
    CGFloat labelHeight = button.titleLabel.intrinsicContentSize.height;
    CGFloat imageHeight = button.imageView.intrinsicContentSize.height;
    button.imageEdgeInsets = UIEdgeInsetsMake(-1*labelHeight, 0, 0, -1*labelWidth);
    button.titleEdgeInsets = UIEdgeInsetsMake(imageHeight+2, -imageWidth, 0, 0);
}

- (void)setRightViewButton:(UIButton *)button imageTitle:(NSString *)imageTitle{
    [button setTitleColor:[UIColor colorWithRed:0.52 green:0.54 blue:0.59 alpha:1.00] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [button setImage:[UIImage imageNamed:imageTitle] forState:UIControlStateNormal];
}

- (void)setRightButton:(UIButton *)button Title:(NSString *)title{
    [button setTitle:title forState:UIControlStateNormal];
    CGFloat labelWidth = button.titleLabel.intrinsicContentSize.width;
    CGFloat imageWidth = button.imageView.intrinsicContentSize.width;
    CGFloat buttonWidth = [UIScreen mainScreen].bounds.size.width*0.25*0.9;
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -(buttonWidth-labelWidth-imageWidth)/2.0, 0,(buttonWidth-labelWidth-imageWidth)/2.0);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -(buttonWidth-labelWidth-imageWidth)/2.0, 0, (buttonWidth-labelWidth-imageWidth)/2.0);
    
}

- (void)displayMenu:(UIView *)view{
    self.hidden = NO;
    [UIView animateWithDuration:0.4 animations:^{
        [topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.height.mas_equalTo(64);
            make.left.and.width.equalTo(self);
        }];
        [bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.height.mas_equalTo(64);
            make.left.and.width.equalTo(self);
        }];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hiddenMenu{
    if (self.rightButton.selected) {
        [self touchRightButtonCollection:NO follow:NO];
    }
    [UIView animateWithDuration:0.4 animations:^{
        [topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
