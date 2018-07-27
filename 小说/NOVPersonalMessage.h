//
//  NOVUserMessageModel.h
//  小说
//
//  Created by 李飞艳 on 2018/7/26.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface NOVPersonalMessage : JSONModel<NSCoding>
@property(nonatomic,strong) NSString <Optional>*signText;
@property(nonatomic,assign) NSNumber *experience;
@property(nonatomic,assign) NSNumber *userGrade;
@property(nonatomic,assign) NSNumber <Optional>*sex;
@property(nonatomic,strong) NSString <Optional>*location;
@property(nonatomic,strong) NSString <Optional>*school;
@property(nonatomic,strong) NSString <Optional>*company;
@end

@interface NOVSimpleUseMessage : JSONModel<NSCoding>
@property(nonatomic,strong) NSString *username;
@property(nonatomic,strong) NSString *account;
@end

@interface NOVUserMessage : JSONModel<NSCoding>
@property(nonatomic,strong) NOVSimpleUseMessage *simpleUserMessage;
@property(nonatomic,strong) NOVPersonalMessage *userMessage;
@end

@interface NOVObtainUserMessage : JSONModel<NSCoding>
@property(nonatomic,strong) NOVUserMessage *data;
@property(nonatomic,assign) NSInteger status;
@end


