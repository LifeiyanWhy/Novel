//
//  NOVEditViewTableViewCell.m
//  小说
//
//  Created by 李飞艳 on 2018/5/14.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVEditViewTableViewCell.h"
#import "Masonry.h"

@implementation NOVEditViewTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _leftLabel = [[UILabel alloc] init];
        _enumNumber = -1;
        [self.contentView addSubview:_leftLabel];
    }
    return self;
}

-(void)layoutSubviews{
    self.textLabel.font = [UIFont systemFontOfSize:15];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.width.equalTo(self).multipliedBy(0.5);
    }];
    
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self);
        make.right.equalTo(self).offset(-10);
        make.width.equalTo(self).multipliedBy(0.18);
    }];
    _leftLabel.font = [UIFont systemFontOfSize:15];
    _leftLabel.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.00];
    _leftLabel.textAlignment = NSTextAlignmentRight;
}

-(void)drawRect:(CGRect)rect{
    UIColor *color = [UIColor colorWithRed:0.74 green:0.74 blue:0.74 alpha:1.00];
    [color set];
    UIBezierPath *bezierpath = [UIBezierPath bezierPath];
    bezierpath.lineWidth = 1.5;
    bezierpath.lineCapStyle = kCGLineCapButt;
    [bezierpath moveToPoint:CGPointMake(10, self.frame.size.height)];
    [bezierpath addLineToPoint:CGPointMake(self.frame.size.width-10, self.frame.size.height)];
    [bezierpath stroke];
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
