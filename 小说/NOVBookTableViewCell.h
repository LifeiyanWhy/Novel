//
//  NOVBookTableViewCell.h
//  小说
//
//  Created by 李飞艳 on 2018/4/10.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NOVFindModel;

@interface NOVBookTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView *leftImageView;

@property(nonatomic,strong) UILabel *titleLabel;

@property(nonatomic,strong) UILabel *wordNumberLabel;

@property(nonatomic,strong) UILabel *lastUpdateTimeLablel;

@property(nonatomic,strong) UILabel *joinNumberLabel;

@property(nonatomic,strong) UILabel *contentLabel;

-(void)updateCellModel:(NOVFindModel *)model;
@end
