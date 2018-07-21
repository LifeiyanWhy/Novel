//
//  NOVReadEditVIew.h
//  小说
//
//  Created by 李飞艳 on 2018/7/20.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NOVReadEditVIew : UIView
@property(nonatomic,strong) UIButton *backButton;

@property(nonatomic,strong) UIButton *partButton; //本段说

@property(nonatomic,strong) UIButton *rightButton;

@property(nonatomic,strong) UIButton *catalogButton;

@property(nonatomic,strong) UIButton *nightButton;

@property(nonatomic,strong) UIButton *nextChapterButton;

@property(nonatomic,strong) UIButton *collectionButton;
@property(nonatomic,strong) UIButton *followButton;
@property(nonatomic,strong) UIButton *commentButton;

//- (void)displayMenu;
//- (void)hideMenu;

- (void)touchRightButtonCollection:(BOOL)collection follow:(BOOL)follow;

- (void)collectionButtonChange:(UIButton *)button;
- (void)followButtonChange:(UIButton *)button;
@end
