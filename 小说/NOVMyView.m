//
//  NOVMyView.m
//  小说
//
//  Created by 李飞艳 on 2018/5/7.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVMyView.h"
#import "Masonry.h"
#import "NOVMyheadView.h"

@implementation NOVMyView{
    NSArray *imageArray1;
    NSArray *imageArray2;
    NSArray *titleArray1;
    NSArray *titleArray2;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _myInformationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_myInformationButton];
        
        _myfootprintButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_myfootprintButton];

        _tableView = [[UITableView alloc] init];
        [self addSubview:_tableView];
        
        _lightSwitch = [[UISwitch alloc] init];
        _lightSwitch.on = NO;
        _lightSwitch.onTintColor = [UIColor colorWithRed:0.15 green:0.65 blue:0.6 alpha:1.00];
        
        NSLog(@"%f",self.frame.size.height);
        _headview = [[NOVMyheadView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*0.43) Size:self.frame.size];
        [_headview.myImageButton setImage:[UIImage imageNamed:@"cellimage.jpg"] forState:UIControlStateNormal];
        
        titleArray1 = @[@"我的收藏",@"我的足迹",@"我赞过的"];
        titleArray2 = @[@"清除缓存",@"夜间模式",@"设置"];
        
        imageArray1 = @[@"收藏-3.png",@"足迹.png",@"赞.png"];
        imageArray2 = @[@"清除缓存.png",@"夜间-4.png",@"设置-3.png"];
    }
    return self;
}

-(void)layoutSubviews{
    self.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    
      
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.equalTo(self).offset(-49);
        make.left.and.right.equalTo(self);
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = _headview;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.bounces = NO;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    } else if (section == 1){
        return 3;
    }else{
        return 1;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.frame.size.height*0.08;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    switch (indexPath.section) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:imageArray1[indexPath.row]];
            cell.textLabel.text = titleArray1[indexPath.row];
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:imageArray2[indexPath.row]];
            cell.textLabel.text = titleArray2[indexPath.row];
            if (indexPath.row == 1) {
                cell.accessoryView = _lightSwitch;
            }
            break;
        case 2:
            cell.textLabel.text = @"关于";
            cell.imageView.image = [UIImage imageNamed:@"关于.png"];
            break;
        default:
            break;
    }
    return cell;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
