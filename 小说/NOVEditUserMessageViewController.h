//
//  NOVEditUserMessageViewController.h
//  小说
//
//  Created by 李飞艳 on 2018/7/25.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NOVUserMessage;
typedef void(^userMessage)(NOVUserMessage *userMessage);
@interface NOVEditUserMessageViewController : UIViewController
@property(nonatomic,strong) NOVUserMessage *userMessage;
@property(nonatomic,copy) userMessage userMessageBlock;
@end
