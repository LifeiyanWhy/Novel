//
//  NOVMessageCellModel.h
//  小说
//
//  Created by 李飞艳 on 2018/4/20.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIImage+AFNetworking.h>

@interface NOVMessageCellModel : NSObject

@property(nonatomic,strong) NSString *name;

@property(nonatomic,strong) NSString *messageContent;

@property(nonatomic,strong) NSString *timeContent;

@property(nonatomic,strong) NSString *rightContent;

@property(nonatomic,assign) CGFloat cellheight;

-(instancetype)init;

@end
