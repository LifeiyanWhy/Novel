//
//  NOVUserMessageTableViewCell.m
//  小说
//
//  Created by 李飞艳 on 2018/7/26.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVUserMessageTableViewCell.h"
#import "Masonry.h"

@implementation NOVUserMessageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _leftLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_leftLabel];
        
        _rightLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_rightLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.left.equalTo(self.contentView);
        make.width.equalTo(self.contentView).multipliedBy(0.2f);
    }];
    _leftLabel.font = [UIFont systemFontOfSize:13];
    _leftLabel.textColor = [UIColor grayColor];
    _leftLabel.textAlignment = NSTextAlignmentCenter;
    
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.right.equalTo(self.contentView);
        make.left.equalTo(_leftLabel.mas_right);
    }];
    _rightLabel.font = [UIFont systemFontOfSize:13];
    _rightLabel.textColor = [UIColor blackColor];
    _rightLabel.textAlignment = NSTextAlignmentLeft;
}

-(void)drawRect:(CGRect)rect{
    UIColor *color = [UIColor lightGrayColor];
    [color set];
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 1;
    [path moveToPoint:CGPointMake(0, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [path stroke];
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
