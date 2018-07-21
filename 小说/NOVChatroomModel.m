//
//  NOVChatroomModel.m
//  小说
//
//  Created by 李飞艳 on 2018/5/3.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVChatroomModel.h"

@implementation NOVChatroomModel

- (instancetype)initWithMessage:(NSString *)message{
    self = [super init];
    if (self) {
        //发送消息
        _messSenderType = MessageSenderTypeSend;
        _massage = message;
        _imageurl = @"cellimage.jpg";
        
        CGFloat messageheight = [_massage boundingRectWithSize:CGSizeMake(([UIScreen mainScreen].bounds.size.width)*0.7-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
        _cellHeight = 25 + messageheight;
    }
    return self;
}

- (instancetype)initWithReceiveMessageModel:(NOVChatroomReceiveModel *)chatroomReceiveModel{
    self = [super init];
    if (self) {
        //接收消息
        _messSenderType = MessageSenderTypeReceive;
        _receiveModel = chatroomReceiveModel;
    }
    return self;
}

@end
