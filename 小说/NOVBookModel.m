//
//  NOVBookModel.m
//  小说
//
//  Created by 李飞艳 on 2018/4/10.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVBookModel.h"

@implementation NOVBookModel
-(instancetype)init{
    _title = @"标题...";
    
    _wordNumber = @"字数:x万 |已更新至:xxxx";
    
    _lastUpdateTime = @"最后更新时间:2018.04.10";
    
    _joinNumber = @"参与人数:10";
    
    _content = @"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
    
    return self;
}
@end
