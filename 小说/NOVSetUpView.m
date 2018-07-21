//
//  NOVSetUpView.m
//  小说
//
//  Created by 李飞艳 on 2018/4/24.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVSetUpView.h"
#import "Masonry.h"

@implementation NOVSetUpView{
    UIButton *whiteButton;
    UIButton *pinkButton;
    UIButton *yellowButton;
    UIButton *greenButton;
    UIButton *blueButton;
    UIButton *blackButton;
    UISlider *brightNessSlider;
}


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        whiteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:whiteButton];
        whiteButton.tag = 1;
        
        pinkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:pinkButton];
        pinkButton.tag = 2;
        
        yellowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:yellowButton];
        yellowButton.tag = 3;
        
        greenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:greenButton];
        greenButton.tag = 4;
        
        blueButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:blueButton];
        blueButton.tag = 5;
        
        blackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:blackButton];
        blackButton.tag = 6;
        
        brightNessSlider = [[UISlider alloc] init];
        [self addSubview:brightNessSlider];
    }
    return self;
}

- (void)layoutSubviews{
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    
    NSLog(@"setupViewlayoutSubviews====%f",self.frame.size.width);
    whiteButton.backgroundColor = [UIColor whiteColor];
    [whiteButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(self.frame.size.width*0.03);
        make.width.equalTo(self).multipliedBy(0.12);
        make.bottom.equalTo(self).offset(self.frame.size.height*-0.25);
        make.height.equalTo(self.mas_width).multipliedBy(0.12);
    }];
    [self setupButton:whiteButton];
    
    pinkButton.backgroundColor = [UIColor colorWithRed:1.00 green:0.8 blue:0.8 alpha:1.00];
    [pinkButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteButton.mas_right).offset(self.frame.size.width*0.04);
        make.top.and.bottom.and.width.equalTo(whiteButton);
    }];
    [self setupButton:pinkButton];
    
    yellowButton.backgroundColor = [UIColor colorWithRed:1.00 green:1.00 blue:0.79 alpha:1.00];
    [yellowButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pinkButton.mas_right).offset(self.frame.size.width*0.04);
        make.top.and.bottom.and.width.equalTo(whiteButton);
    }];
    [self setupButton:yellowButton];
    
    greenButton.backgroundColor = [UIColor colorWithRed:0.8 green:0.99 blue:0.8 alpha:1.00];
    [greenButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yellowButton.mas_right).offset(self.frame.size.width*0.04);
        make.top.and.bottom.and.width.equalTo(whiteButton);
    }];
    [self setupButton:greenButton];
    
    blueButton.backgroundColor = [UIColor colorWithRed:0.6 green:0.8 blue:0.8 alpha:1.00];
    [blueButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(greenButton.mas_right).offset(self.frame.size.width*0.04);
        make.top.and.bottom.and.width.equalTo(whiteButton);
    }];
    [self setupButton:blueButton];
    
    blackButton.backgroundColor = [UIColor blackColor];
    [blackButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(blueButton.mas_right).offset(self.frame.size.width*0.04);
        make.top.and.bottom.and.width.equalTo(whiteButton);
    }];
    [self setupButton:blackButton];
    
    [brightNessSlider mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteButton);
        make.right.equalTo(blackButton);
        make.top.equalTo(self);
        make.height.equalTo(self).multipliedBy(0.3);
    }];
    brightNessSlider.minimumValueImage = [UIImage imageNamed:@"太阳.png"];
    brightNessSlider.maximumValueImage = [UIImage imageNamed:@"太阳-2.png"];
}

-(void)setupButton:(UIButton *)button{
    button.layer.cornerRadius = 22;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = [UIColor grayColor].CGColor;
    button.layer.borderWidth = 0.5;
    [button addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)changeColor:(UIButton *)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchColorButton:color:)]) {
        switch (button.tag) {
            case 1:
                [self.delegate touchColorButton:button color:[UIColor whiteColor]];
                break;
            case 2:
                [self.delegate touchColorButton:button color:[UIColor colorWithRed:1.00 green:0.8 blue:0.8 alpha:1.00]];
                break;
            case 3:
                [self.delegate touchColorButton:button color:[UIColor colorWithRed:1.00 green:1.00 blue:0.79 alpha:1.00]];
                break;
            case 4:
                [self.delegate touchColorButton:button color:[UIColor colorWithRed:0.8 green:0.99 blue:0.8 alpha:1.00]];
                break;
            case 5:
                [self.delegate touchColorButton:button color:[UIColor colorWithRed:0.6 green:0.8 blue:0.8 alpha:1.00]];
                break;
            case 6:
                [self.delegate touchColorButton:button color:[UIColor blackColor]];
                break;
            default:
                break;
        }
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
