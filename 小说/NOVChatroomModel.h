//
//  NOVChatroomModel.h
//  小说
//
//  Created by 李飞艳 on 2018/5/3.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIImage+AFNetworking.h>

typedef NS_OPTIONS(NSUInteger, MessageSenderType) {
    MessageSenderTypeSend = 1,
    MessageSenderTypeReceive
};

@class NOVChatroomReceiveModel;

@interface NOVChatroomModel : NSObject

//消息内容
@property(nonatomic,strong) NSString *massage;

@property(nonatomic,strong) NSString *imageurl;

@property(nonatomic,strong) NOVChatroomReceiveModel *receiveModel;

//消息类型（接收／发送）
@property(nonatomic,assign) MessageSenderType messSenderType;

//cell高度
@property(nonatomic,assign) CGFloat cellHeight;

- (instancetype)initWithMessage:(NSString *)message;

//通过接收到的消息记录初始化一条聊天记录
- (instancetype)initWithReceiveMessageModel:(NOVChatroomReceiveModel *)chatroomReceiveModel;

@end
