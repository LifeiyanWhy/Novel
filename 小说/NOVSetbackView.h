//
//  NOVSetbackView.h
//  小说
//
//  Created by 李飞艳 on 2018/5/24.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NOVMystartModel;

@interface NOVSetbackView : UIView<UITableViewDataSource>

@property(nonatomic,strong) UIButton *close;

@property(nonatomic,strong) UIImageView *coverImage;

@property(nonatomic,strong) UITableView *tableview;

-(instancetype)initWithFrame:(CGRect)frame model:(NOVMystartModel *)model;

@end
