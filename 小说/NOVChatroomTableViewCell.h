//
//  NOVChatroomTableViewCell.h
//  小说
//
//  Created by 李飞艳 on 2018/5/2.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  NOVChatroomTableViewCellDelegate <NSObject>

@optional

- (void)touchMessageLabel;

- (void)touchBlankView;

@end

@interface NOVChatroomTableViewCell : UITableViewCell<UIGestureRecognizerDelegate>

@property(nonatomic,strong) id<NOVChatroomTableViewCellDelegate> delegate;

//头像
@property(nonatomic,strong) UIImageView *myImage;

//聊天气泡
@property(nonatomic,strong) UIImageView *chatBackgroundImage;

//文本框
@property(nonatomic,strong) UILabel *label;

- (void)makeCellWithImageUrl:(NSString *)imageUrl message:(NSString *)message;

@end
