//
//  NOVObtainBookList.m
//  小说
//
//  Created by 李飞艳 on 2018/6/26.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVObtainBookList.h"
#import <AFNetworking.h>

@implementation NOVObtainBookList

-(void)obtainBookListWithType:(NOVObtainListType)listType succeed:(succeedBlock)succeedBlock fail:(failBlock)failBlock{
    NSString *urlString = @"http://47.95.207.40/branch/book";

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succeedBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
    }];
}

@end
