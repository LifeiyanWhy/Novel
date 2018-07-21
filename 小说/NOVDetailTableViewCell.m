//
//  NOVDetailTableViewCell.m
//  小说
//
//  Created by 李飞艳 on 2018/5/15.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVDetailTableViewCell.h"
#import "Masonry.h"

@implementation NOVDetailTableViewCell

-(void)layoutSubviews{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.frame.size.width*0.07);
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.width.equalTo(self).multipliedBy(0.07);
    }];
    
    if (self.detailTextLabel.text) {
        [self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(self.frame.size.height*0.15);
            make.height.equalTo(self).multipliedBy(0.4);
            make.left.equalTo(self.imageView.mas_right).offset(10);
            make.width.equalTo(self).multipliedBy(0.4);
        }];
        
        [self.detailTextLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.textLabel.mas_bottom).offset(self.frame.size.height*0.03);
            make.height.equalTo(self).multipliedBy(0.3);
            make.left.equalTo(self.textLabel);
            make.width.equalTo(self).multipliedBy(0.7);
        }];
        self.detailTextLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.00];
    } else {
        [self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self).multipliedBy(0.4);
            make.centerY.equalTo(self);
            make.left.equalTo(self.imageView.mas_right).offset(10);
            make.width.equalTo(self).multipliedBy(0.4);
        }];
    }
    self.textLabel.font = [UIFont systemFontOfSize:14];
}

-(void)drawRect:(CGRect)rect{
    UIColor *color = [UIColor colorWithRed:0.74 green:0.74 blue:0.74 alpha:1.00];
    [color set];
    UIBezierPath *bezierpath = [UIBezierPath bezierPath];
    bezierpath.lineWidth = 1.5;
    bezierpath.lineCapStyle = kCGLineCapButt;
    [bezierpath moveToPoint:CGPointMake(0, self.frame.size.height)];
    [bezierpath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
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
