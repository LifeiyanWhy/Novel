//
//  NOVObatinBookContent.m
//  小说
//
//  Created by 李飞艳 on 2018/6/27.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVObatinBookContent.h"
#import <AFNetworking.h>
#import "NOVDataModel.h"

@implementation NOVObatinBookContent
//根据作品ID和父节点ID获取章节内容
-(void)ObtainBookContenWithBranchId:(NSInteger)branchId succeed:(succeedBlock)succeedBlock fail:(failBlock)failBlock{
    NSString* urlString = [NSString stringWithFormat:@"http://47.95.207.40/branch/book/branch/%ld",(long)branchId];  
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succeedBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
    }];
}

//获取首段ID
-(void)getBookFirstChapterIdWithBookID:(NSInteger)bookId succeed:(succeedBlock)succeedBlock fail:(failBlock)failBlock{
    NSString *urlString = [NSString stringWithFormat:@"http://47.95.207.40/branch/book/%ld/branch?parentId=0",(long)bookId];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succeedBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
    }];
}

//根据作品ID，以及要查看子段落的父节点ID获取段落(本段的续写列表)
-(void)ObtainChapterWithBookId:(NSInteger)bookId ParentId:(NSInteger)parentId succeed:(succeedBlock)succeedBlock fail:(failBlock)failBlock{
    NSString* urlString = [NSString stringWithFormat:@"http://47.95.207.40/branch/book/%ld/branch?%ld",(long)bookId,(long)parentId];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succeedBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
    }];
}
// 关注一本书
-(void)followBookWithBookId:(NSInteger)bookId succeed:(succeedBlock)succeedBlock fail:(failBlock)failBlock{
    NOVDataModel *datamodel = [NOVDataModel shareInstance];
    NSString *token = [NSString stringWithFormat:@"Bearer %@",[datamodel getToken]];
    NSString *urlString = [NSString stringWithFormat:@"http://47.95.207.40/branch/user/book/%ld/focusOn",(long)bookId];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manager PUT:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succeedBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
    }];
}
//取消关注
-(void)cancelFollowBookId:(NSInteger)bookId succeed:(succeedBlock)succeedBlock fail:(failBlock)failBlock{
    NOVDataModel *datamodel = [NOVDataModel shareInstance];
    NSString *token = [NSString stringWithFormat:@"Bearer %@",[datamodel getToken]];
    NSString *urlString = [NSString stringWithFormat:@"http://47.95.207.40/branch/user/book/%ld/focusOn",(long)bookId];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manager DELETE:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succeedBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
    }];
}

@end
