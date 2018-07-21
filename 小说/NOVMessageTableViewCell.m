//
//  NOVMessageTableViewCell.m
//  小说
//
//  Created by 李飞艳 on 2018/4/20.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVMessageTableViewCell.h"
#import "Masonry.h"
#import "NOVMessageCellModel.h"

@implementation NOVMessageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _nameLabel = [[UILabel alloc] init];
        [self addSubview:_nameLabel];
    
        _messageContent = [[UILabel alloc] init];
        [self addSubview:_messageContent];
        
        _timeLabel = [[UILabel alloc] init];
        [self addSubview:_timeLabel];
        
        _rightLabel = [[UILabel alloc] init];
        [self addSubview:_rightLabel];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        longPress.delegate = self;
        [self addGestureRecognizer:longPress];
    }
    return self;
}

//长按cell
-(void)longPress:(UIGestureRecognizer *)gesture{
    //手势方法只执行一次
    if (gesture.state == UIGestureRecognizerStateEnded) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(longPressTableView:Cell:touchPoint:)]) {
        CGPoint point = [gesture locationInView:(((self.superview).superview).superview).superview];
        NSLog(@"====%f",point.y);
        [self.delegate longPressTableView:(UITableView *)[[self superview] superview] Cell:self touchPoint:point];
    }
}

-(void)layoutSubviews{
   [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self).offset(10);
       make.height.equalTo(self.mas_width).multipliedBy(0.15);
       make.left.equalTo(self).offset(10);
       make.width.equalTo(self).multipliedBy(0.15);
   }];
    self.imageView.layer.cornerRadius = 30;
    self.imageView.layer.masksToBounds = YES;
    
    UIImageView *separatorImage = [[UIImageView alloc] init];
    [self addSubview:separatorImage];
    separatorImage.backgroundColor = [UIColor lightGrayColor];
    [separatorImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self.imageView.mas_right);
        make.right.equalTo(self);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView);
        make.height.equalTo(self.mas_width).multipliedBy(0.05f);
        make.left.equalTo(self.imageView.mas_right).offset(5);
        make.width.equalTo(self).multipliedBy(0.5);
    }];
    [_nameLabel setTextColor:[UIColor grayColor]];
    [_nameLabel setFont:[UIFont systemFontOfSize:12]];
    
    [_messageContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(5);
        make.left.equalTo(_nameLabel);
        make.width.equalTo(self).multipliedBy(0.6f);
    }];
    [_messageContent setTextColor:[UIColor grayColor]];
    [_messageContent setFont:[UIFont systemFontOfSize:12]];
    _messageContent.numberOfLines = 0;
    [_messageContent sizeToFit];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_messageContent.mas_bottom).offset(5);
        make.height.equalTo(self.mas_width).multipliedBy(0.04);
        make.left.equalTo(self.imageView.mas_right).offset(5);
        make.width.equalTo(self).multipliedBy(0.3);
    }];
    [_timeLabel setTextColor:[UIColor grayColor]];
    [_timeLabel setFont:[UIFont systemFontOfSize:12]];
    
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.imageView);
        make.right.equalTo(self).offset(-5);
        make.left.equalTo(_messageContent.mas_right).offset(15);
    }];
    _rightLabel.numberOfLines = 0;
    [_rightLabel setTextColor:[UIColor grayColor]];
    [_rightLabel setFont:[UIFont systemFontOfSize:12]];
}

- (void)upDateCellWithModel:(NOVMessageCellModel *)messageCellModel{
    [_nameLabel setText:messageCellModel.name];
    [_messageContent setText:messageCellModel.messageContent];
    [_timeLabel setText:messageCellModel.timeContent];
    [_rightLabel setText:messageCellModel.rightContent];
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
