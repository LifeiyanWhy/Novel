//
//  NOVFindTableViewCell.h
//  小说
//
//  Created by 李飞艳 on 2018/4/13.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@class NOVbookMessage;

@interface NOVFindTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView *leftImageView;

@property(nonatomic,strong) UILabel *titleLabel;

@property(nonatomic,strong) UILabel *contentLabel;

@property(nonatomic,strong) UILabel *authorLabel;

@property(nonatomic,strong) UIImageView *myImageView;

@property(nonatomic,strong) UIButton *readButton;

@property(nonatomic,strong) UIView *midView;

@property(nonatomic,strong) UIView *bottomView;

@property(nonatomic,strong) UILabel *writeNumber;

@property(nonatomic,strong) UIButton *numberOfjoin;

@property(nonatomic,strong) UIButton *numberOfWords;

@property(nonatomic,strong) UILabel *startContentLabel;

@property(nonatomic,strong) UILabel *updateContentLabel;

@property(nonatomic,assign) BOOL isOpen;

-(void)cellOpen;

-(void)cellClose;

- (void)updateCellWithModel:(NOVbookMessage*)model;

@end
