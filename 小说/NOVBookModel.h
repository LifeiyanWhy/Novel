//
//  NOVBookModel.h
//  小说
//
//  Created by 李飞艳 on 2018/4/10.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NOVBookModel : NSObject

@property(nonatomic,strong) NSString *title;

@property(nonatomic,strong) NSString *wordNumber;

@property(nonatomic,strong) NSString *lastUpdateTime;

@property(nonatomic,strong) NSString *joinNumber;

@property(nonatomic,strong) NSString *content;

-(instancetype)init;
@end
