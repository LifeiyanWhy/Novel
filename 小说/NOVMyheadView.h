//
//  NOVMyheadView.h
//  小说
//
//  Created by 李飞艳 on 2018/5/8.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NOVMyheadView : UIView

@property(nonatomic,strong) UIButton *myImageButton;

@property(nonatomic,strong) UILabel *nameLabel;

@property(nonatomic,strong) UILabel *profileLabel;

@property(nonatomic,strong) UIButton *myworkButton;

@property(nonatomic,strong) UIButton *myfollowButton;

@property(nonatomic,strong) UIButton *myfansButton;

@property(nonatomic,strong) NOVMyheadView *headview;

-(instancetype)initWithFrame:(CGRect)frame Size:(CGSize)size;

@end
