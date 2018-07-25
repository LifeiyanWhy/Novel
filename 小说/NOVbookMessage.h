//
//  NOVFindModel.h
//  小说
//
//  Created by 李飞艳 on 2018/6/26.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface NOVbookMessage : JSONModel

@property(nonatomic,assign) NSInteger bookId;

@property(nonatomic,strong) NSString *bookName;

@property(nonatomic,strong) NSString *content;

@property(nonatomic,assign) int writeNum;

@end

@interface NOVAllBookMesssage : JSONModel

@property(nonatomic,assign) int status;

@property(nonatomic,strong) NSArray<NOVbookMessage *>* data;

@end
