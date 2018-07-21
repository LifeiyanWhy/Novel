//
//  NOVMessageTableViewCell.h
//  小说
//
//  Created by 李飞艳 on 2018/4/20.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NOVMessageCellModel;

@class NOVMessageTableViewCell;

@protocol NOVMessageTableViewCellDelegate <NSObject>

@optional

-(void)longPressTableView:(UITableView *)tableView Cell:(NOVMessageTableViewCell *)messageTableViewCell touchPoint:(CGPoint )point;

@end

@interface NOVMessageTableViewCell : UITableViewCell<UIGestureRecognizerDelegate>

@property(nonatomic,strong) UILabel *nameLabel;

@property(nonatomic,strong) UILabel *messageContent;

@property(nonatomic,strong) UILabel *timeLabel;

@property(nonatomic,strong) UILabel *rightLabel;

@property(nonatomic,strong) NSIndexPath *indexPath;

@property(nonatomic,weak) id <NOVMessageTableViewCellDelegate>delegate;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)upDateCellWithModel:(NOVMessageCellModel *)messageCellModel;

@end
