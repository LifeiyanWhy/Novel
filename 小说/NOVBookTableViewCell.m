//
//  NOVBookTableViewCell.m
//  小说
//
//  Created by 李飞艳 on 2018/4/10.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVBookTableViewCell.h"
#import "Masonry.h"
#import "NOVBookModel.h"

@implementation NOVBookTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _leftImageView = [[UIImageView alloc] init];
        [self addSubview:_leftImageView];
        
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        
        _wordNumberLabel = [[UILabel alloc] init];
        [self addSubview:_wordNumberLabel];
        
        _lastUpdateTimeLablel = [[UILabel alloc] init];
        [self addSubview:_lastUpdateTimeLablel];
        
        _joinNumberLabel = [[UILabel alloc] init];
        [self addSubview:_joinNumberLabel];
        
        _contentLabel = [[UILabel alloc] init];
        [self addSubview:_contentLabel];
        
//        _writeButton = [[UIButton alloc] init];
//        [self addSubview:_writeButton];
    }
    return self;
}

-(void)layoutSubviews{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    //设置cell阴影
//    self.layer.shadowPath =[UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOpacity = 0.8f;
    self.layer.shadowOffset = CGSizeMake(-2, 3);
    self.layer.shadowRadius = 4.0f;
    self.layer.masksToBounds = NO;
    
    _leftImageView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self).multipliedBy(0.9f);
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(self.frame.size.width*0.015);
        make.width.equalTo(self).multipliedBy(0.23f);
    }];
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImageView.mas_right).offset(self.frame.size.height*0.05);
        make.width.equalTo(self).multipliedBy(0.5f);
        make.top.equalTo(_leftImageView);
        make.height.equalTo(self).multipliedBy(0.18f);
    }];
    [_titleLabel setFont:[UIFont systemFontOfSize:15]];
    
    
    [_wordNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.right.equalTo(self).offset(self.frame.size.height*0.05*-1);
        make.top.equalTo(_titleLabel.mas_bottom);
        make.height.equalTo(self).multipliedBy(0.15f);
    }];
    [_wordNumberLabel setFont:[UIFont systemFontOfSize:12]];
    [_wordNumberLabel setTextColor:[UIColor grayColor]];
    
    
    [_lastUpdateTimeLablel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.right.equalTo(self).offset(self.frame.size.height*0.05*-1);
        make.top.equalTo(_wordNumberLabel.mas_bottom);
        make.height.equalTo(self).multipliedBy(0.15f);
    }];
    [_lastUpdateTimeLablel setFont:[UIFont systemFontOfSize:12]];
    [_lastUpdateTimeLablel setTextColor:[UIColor grayColor]];
    

    [_joinNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.right.equalTo(self).offset(self.frame.size.height*0.05*-1);
        make.top.equalTo(_lastUpdateTimeLablel.mas_bottom);
        make.height.equalTo(self).multipliedBy(0.15f);
    }];
    [_joinNumberLabel setFont:[UIFont systemFontOfSize:12]];
    [_joinNumberLabel setTextColor:[UIColor grayColor]];
    
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.right.equalTo(self).offset(self.frame.size.height*0.05*-1);
        make.bottom.equalTo(self).offset(self.frame.size.height*0.05*-1);
        make.height.equalTo(self).multipliedBy(0.3f);
    }];
    _contentLabel.numberOfLines = 0;
    [_contentLabel setFont:[UIFont systemFontOfSize:12]];
    [_contentLabel setTextColor:[UIColor grayColor]];

//    [_writeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_titleLabel);
//        make.height.equalTo(_titleLabel);
//        make.right.equalTo(self.mas_right).offset(self.frame.size.height*0.05*-1);
//        make.width.equalTo(self).multipliedBy(0.16f);
//    }];
//    _writeButton.layer.cornerRadius = 5;
//    _writeButton.layer.masksToBounds = YES;
//    [_writeButton.layer setBorderWidth:2];
//    [_writeButton.layer setBorderColor:[UIColor colorWithRed:0.38 green:0.66 blue:0.62 alpha:1.00].CGColor];
//    [_writeButton setTitle:@"我要续写" forState:UIControlStateNormal];
//    [_writeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    _writeButton.titleLabel.font = [UIFont systemFontOfSize:10];
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 5;
    frame.origin.y += 20;
    frame.size.height -= 20;
    frame.size.width -= 15;
    [super setFrame:frame];
}

-(void)updateCellModel:(NOVBookModel *)model{
    [_titleLabel setText:model.title];
    [_wordNumberLabel setText:model.wordNumber];
    [_lastUpdateTimeLablel setText:model.lastUpdateTime];
    [_joinNumberLabel setText:model.joinNumber];
    [_contentLabel setText:model.content];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
