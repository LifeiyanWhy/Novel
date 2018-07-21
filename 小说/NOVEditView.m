//
//  NOVEditView.m
//  小说
//
//  Created by 李飞艳 on 2018/5/12.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVEditView.h"
#import "Masonry.h"

@implementation NOVEditView{
    UIView *headView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc] init];
        [self addSubview:_tableView];
        
        headView = [[UIView alloc] init];
        _tableView.tableHeaderView = headView;
        
        _novelImage = [[UIImageView alloc] init];
        _novelImage.userInteractionEnabled = YES;
        [headView addSubview:_novelImage];
        
        _changeImage = [[UITapGestureRecognizer alloc] init];
        //给image添加手势，用于点击更换图像
        [_novelImage addGestureRecognizer:_changeImage];
        
        _novelName = [[UITextField alloc] init];
        [headView addSubview:_novelName];
    }
    return self;
}

-(void)layoutSubviews{
    self.backgroundColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00];

    headView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*0.15);
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    _novelImage.backgroundColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1.00];
    [_novelImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(headView).multipliedBy(0.8);
        make.centerY.equalTo(headView);
        make.left.equalTo(headView).offset(self.frame.size.width*0.04);
        make.width.equalTo(headView).multipliedBy(0.17f);
    }];
    
    //headView
    UILabel *novelName = [[UILabel alloc] init];
    [headView addSubview:novelName];
    [novelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_novelImage);
        make.height.equalTo(headView).multipliedBy(0.2);
        make.left.equalTo(_novelImage.mas_right).offset(5);
        make.width.equalTo(headView).multipliedBy(0.25);
    }];
    novelName.text = @"作品名称:";
    novelName.textColor = [UIColor blackColor];
    
    [_novelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(novelName.mas_bottom).offset(10);
        make.height.equalTo(headView).multipliedBy(0.2);
        make.left.equalTo(_novelImage.mas_right).offset(5);
        make.right.equalTo(self).offset(-10);
    }];
    _novelName.placeholder = @"15字以内";
    _novelName.font = [UIFont systemFontOfSize:14];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_novelName.mas_bottom);
        make.left.and.right.equalTo(_novelName);
        make.height.mas_equalTo(1.5);
    }];
    imageView.backgroundColor = [UIColor colorWithRed:0.74 green:0.74 blue:0.74 alpha:1.00];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
