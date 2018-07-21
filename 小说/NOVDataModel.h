//
//  NOVDataModel.h
//  小说
//
//  Created by 李飞艳 on 2018/6/9.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NOVDataModel : NSObject

+(NOVDataModel *)shareInstance;

-(void)updateToken:(NSString *)token refreshToken:(NSString *)refreshToken;

-(NSString *)getToken;

-(NSString *)getRefreshToken;

-(void)updateFollowBookListWithArray:(NSMutableArray *)followBookList;
//获取关注列表
-(NSArray *)getFollowBookList;

@end
