//
//  NOVEditView.h
//  小说
//
//  Created by 李飞艳 on 2018/5/12.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NOVEditView : UIView

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UIImageView *novelImage;

@property(nonatomic,strong) UITextField *novelName;

@property(nonatomic,strong) UITapGestureRecognizer *changeImage;

@end
