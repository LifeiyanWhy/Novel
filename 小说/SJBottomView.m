//
//  SJBottomView.m
//  小说
//
//  Created by 李飞艳 on 2018/4/9.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "SJBottomView.h"
#import "Masonry.h"
#import "NOVBookTableViewCell.h"
#import "NOVBookModel.h"

#define Height [UIScreen mainScreen].bounds.size.height
@implementation SJBottomView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

-(void)addUI{
    self.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    _tableView = [[UITableView alloc] init];
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.95f);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
    }];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
