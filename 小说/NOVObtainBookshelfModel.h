//
//  NOVObtainBookshelfModel.h
//  小说
//
//  Created by 李飞艳 on 2018/7/21.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successBlock)(id  _Nullable responseObject);

typedef void(^failBlock)(NSError * _Nonnull error);

@interface NOVObtainBookshelfModel : NSObject
//获取关注列表
-(void)obtainFollowBookListSucceed:(successBlock _Nullable )succeedBlock failure:(failBlock _Nonnull )failBlock;

@end
