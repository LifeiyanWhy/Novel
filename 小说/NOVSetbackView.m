//
//  NOVSetbackView.m
//  小说
//
//  Created by 李飞艳 on 2018/5/24.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVSetbackView.h"
#import "Masonry.h"
#import "NOVMystartModel.h"

@implementation NOVSetbackView{
    NOVMystartModel *selfmodel;
}

-(instancetype)initWithFrame:(CGRect)frame model:(NOVMystartModel *)model{
    self = [super initWithFrame:frame];
    if (self) {
        selfmodel = model;
        self.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
        
        _close = [[UIButton alloc] init];
        [self addSubview:_close];
        
        _coverImage = [[UIImageView alloc] init];
        [_coverImage setImage:model.bookImage];
        
        _tableview = [[UITableView alloc] init];
        _tableview.dataSource = self;
        [self addSubview:_tableview];
    }
    return self;
}

-(void)layoutSubviews{
    [_close mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.width.equalTo(self).multipliedBy(0.13);
        make.top.equalTo(self).offset(15);
        make.height.equalTo(self).multipliedBy(0.04);
    }];
    [_close setTitle:@"关闭" forState:UIControlStateNormal];
    [_close setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _close.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [_tableview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.equalTo(self).offset(self.frame.size.height*0.1);
        make.bottom.equalTo(self).offset(self.frame.size.height*-0.03);
    }];
    _tableview.backgroundColor = [UIColor colorWithRed:0.9 green:0.93 blue:0.92 alpha:1.00];
    _tableview.showsVerticalScrollIndicator = NO;
    _tableview.showsHorizontalScrollIndicator = NO;
    _tableview.bounces = NO;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, self.frame.size.height*0.1, self.frame.size.width, self.frame.size.height*0.35);
    [view addSubview:_coverImage];
    [_coverImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(view).multipliedBy(0.6);
        make.centerY.equalTo(view);
        make.width.equalTo(view).multipliedBy(0.3);
        make.centerX.equalTo(view);
    }];
    _coverImage.backgroundColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1.00];
    _tableview.tableHeaderView = view;
    _tableview.tableFooterView = [[UIView alloc] init];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor colorWithRed:0.15 green:0.17 blue:0.19 alpha:1.00];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"作品名称";
                cell.detailTextLabel.text = selfmodel.name;
                break;
            case 1:
                cell.textLabel.text = @"作品简介";
                break;;
            case 2:
                cell.textLabel.text = @"作品开头";
                break;
            default:
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"作品类型";
                break;
            case 1:
                cell.textLabel.text = @"可续写人群";
                break;;
            case 2:
                cell.textLabel.text = @"可观看人群";
                break;
            default:
                break;
        }
    }
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(void)drawRect:(CGRect)rect{
    UIColor *color = [UIColor colorWithRed:0.96 green:0.97 blue:0.98 alpha:1.00];
    [color set];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) cornerRadius:20];
    [path fill];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
