//
//  NOVMessageCellModel.m
//  小说
//
//  Created by 李飞艳 on 2018/4/20.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVMessageCellModel.h"
#import <UIImage+AFNetworking.h>

#define Width [UIScreen mainScreen].bounds.size.width

@implementation NOVMessageCellModel

-(instancetype)init{
    _name = @"XXX回复了你";
    
    _messageContent = @"哇哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈刀哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
    
    _timeContent = @"2018-04-20";
    
    _rightContent = @"全是字全是字全是字全是字全是字全是字全是字全是字";
    
    CGFloat h = [_messageContent boundingRectWithSize:CGSizeMake(Width*0.6, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil].size.height;
    _cellheight = 10 + 5  + 5 + Width*0.05 + Width*0.04 + h;
    //10nameLabel距离顶部偏移10，namelabel与messageLabel、timeLabel间距分别5，Width*0.05为nameLabel高度，Width*0.04timeLabel高度，
    
    if (_cellheight < Width * 0.2) {
        _cellheight = Width *0.2;
    }
    
    return self;
}

@end
