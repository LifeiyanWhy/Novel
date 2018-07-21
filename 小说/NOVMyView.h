//
//  NOVMyView.h
//  小说
//
//  Created by 李飞艳 on 2018/5/7.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NOVMyheadView;

@interface NOVMyView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UIButton *myInformationButton;

@property(nonatomic,strong) UIButton *myfootprintButton;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UISwitch *lightSwitch;

@property(nonatomic,strong) NOVMyheadView *headview;

@end

