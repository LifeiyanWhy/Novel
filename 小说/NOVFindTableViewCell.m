//
//  NOVFindTableViewCell.m
//  小说
//
//  Created by 李飞艳 on 2018/4/13.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVFindTableViewCell.h"
#import "NOVFindModel.h"

@implementation NOVFindTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        _leftImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_leftImageView];
        
        _titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        
        _contentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_contentLabel];
        
        _authorLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_authorLabel];
        
        _myImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_myImageView];
        
        _readButton = [[UIButton alloc] init];
        [self.contentView addSubview:_readButton];
        
        _midView = [[UIView alloc] init];
        [self.contentView addSubview:_midView];
        
        _bottomView = [[UIView alloc] init];
        [self.contentView addSubview:_bottomView];
        
        _writeNumber = [[UILabel alloc] init];
        _startContentLabel = [[UILabel alloc] init];
        _updateContentLabel = [[UILabel alloc] init];
    }
    return self;
}

-(void)layoutSubviews{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.layer.cornerRadius = 10;
//    self.layer.masksToBounds = YES;
//    [self.layer setBorderColor:[UIColor grayColor].CGColor];
//    [self.layer setBorderWidth:1];
    
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOpacity = 0.8f;
    self.layer.shadowOffset = CGSizeMake(3, 3);
    self.layer.shadowRadius = 4.0f;
    self.layer.masksToBounds = NO;
    
    _leftImageView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(self.contentView.frame.size.width*0.02);
        make.width.equalTo(self.contentView).multipliedBy(0.2f);
        make.top.equalTo(self.contentView).offset(self.contentView.frame.size.width*0.02);
        make.height.equalTo(self.contentView.mas_width).multipliedBy(0.27);
    }];
    

    [_titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImageView.mas_right).offset(self.contentView.frame.size.width*0.02);
        make.width.equalTo(self.contentView).multipliedBy(0.6f);
        make.top.equalTo(_leftImageView);
        make.height.equalTo(self.contentView.mas_width).multipliedBy(0.07);
    }];
    
    [self setLabel:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(self.contentView.frame.size.width*0.02);
        make.height.equalTo(self.contentView.mas_width).multipliedBy(0.1);
        make.left.equalTo(_titleLabel);
        make.right.equalTo(self.contentView).offset(-1*self.contentView.frame.size.width*0.02);
    }];
    
    
    [_myImageView setImage:[UIImage imageNamed:@"账户-2.png"]];
    [_myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.width.equalTo(self.contentView).multipliedBy(0.05);
        make.bottom.equalTo(_leftImageView);
        make.height.equalTo(self.contentView.mas_width).multipliedBy(0.05);
    }];
    
    [_authorLabel setFont:[UIFont systemFontOfSize:10]];
    [_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_myImageView.mas_right).offset(self.contentView.frame.size.width*0.01);
        make.right.equalTo(_titleLabel);
        make.top.and.bottom.equalTo(_myImageView);
    }];
    _authorLabel.textColor = [UIColor lightGrayColor];
    
    [self setButton:_readButton text:@"阅读"];
    [_readButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_contentLabel);
        make.width.equalTo(self.contentView).multipliedBy(0.1f);
        make.top.equalTo(_titleLabel);
        make.height.equalTo(_titleLabel).multipliedBy(0.8f);
    }];
    
    if (_isOpen) {
        [_midView addSubview:_writeNumber];
        [_writeNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_midView).offset(self.frame.size.width*0.02);
            make.height.equalTo(_midView).multipliedBy(0.25f);
            make.left.equalTo(_midView).offset(self.frame.size.width*0.02);
            make.width.equalTo(_midView).multipliedBy(0.4f);
        }];
        [_writeNumber setFont:[UIFont systemFontOfSize:12]];
        [_writeNumber setTextColor:[UIColor grayColor]];
        
        [_midView addSubview:_startContentLabel];
        [_startContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_midView).offset(self.contentView.frame.size.width*0.02);
            make.right.equalTo(_midView).offset(self.contentView.frame.size.width*-0.02);
            make.top.equalTo(_writeNumber.mas_bottom);
            make.bottom.equalTo(_midView);
        }];
        [self setLabel:_startContentLabel];
        
        [_bottomView addSubview:_updateContentLabel];
        [_updateContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bottomView);
            make.height.equalTo(_bottomView).multipliedBy(0.95);
            make.width.equalTo(_bottomView).multipliedBy(0.96);
            make.centerX.equalTo(_bottomView);
        }];
        [self setLabel:_updateContentLabel];
    }
}

- (void)setButton:(UIButton *)button text:(NSString *)text{
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button.layer setBorderWidth:1];
    [button.layer setBorderColor:[UIColor colorWithRed:0.38 green:0.66 blue:0.62 alpha:1.00].CGColor];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
}

- (void)setLabel:(UILabel *)label{
    if (![label.text  isEqual: @""]) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:3];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
        label.attributedText = attributedString;
        [label setTextColor:[UIColor lightGrayColor]];
        [label setFont:[UIFont systemFontOfSize:12]];
        label.numberOfLines = 0;
    }
    if (label != _contentLabel) {
        [label sizeToFit];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)cellOpen{
    [UIView transitionWithView:_midView duration:0.2 options:UIViewAnimationOptionTransitionFlipFromTop  animations:^{
        [_midView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_leftImageView.mas_bottom);
            make.height.equalTo(self.contentView).multipliedBy(0.3);
            make.left.and.right.equalTo(self);
        }];
    } completion:^(BOOL finished) {        
        [UIView transitionWithView:_bottomView duration:0.3 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_midView.mas_bottom);
                make.left.and.right.equalTo(self.contentView);
                make.height.equalTo(self.contentView).multipliedBy(0.25);
            }];
        } completion:nil];
    }];
}

- (void)cellClose{
    [UIView transitionWithView:_midView duration:0.2 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(0);
        }];
    } completion:^(BOOL finished) {
        [UIView transitionWithView:_midView duration:0.3 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
            [_midView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.and.height.mas_equalTo(0);
            }];
        } completion:nil];
    }];
}


- (void)updateCellWithModel:(NOVFindModel*)model{
    _titleLabel.text = model.bookName;
    _contentLabel.text = model.content;
    _authorLabel.text = @"XXXX";
    _writeNumber.text = [NSString stringWithFormat:@"已参与人数:%d人",model.writeNum];
    _startContentLabel.text = @"startXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
    _updateContentLabel.text = @"updateXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
    [_leftImageView setImage:[UIImage imageNamed:@"bookimage.jpg"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
