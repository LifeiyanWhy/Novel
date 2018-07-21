//
//  NOVStartManager.m
//  小说
//
//  Created by 李飞艳 on 2018/6/5.
//  Copyright © 2018年 李飞艳. All rights reserved.
//
//发布一个作品
#import "NOVStartManager.h"
#import "NOVMystartModel.h"
#import "AFNetworking.h"
#import "NOVDataModel.h"

@implementation NOVStartManager{
//    int bookId;
}

-(void)startNovelWithModel:(NOVMystartModel *)model success:(successBlock)successBlock fail:(failBlock)failBlock{
    NOVDataModel *datamodel = [NOVDataModel shareInstance];
    NSString *token = [NSString stringWithFormat:@"Bearer %@",[datamodel getToken]];
    NSLog(@"token:%@",token);
    NSString *url = @"http://47.95.207.40/branch/book";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSDictionary *parameters = @{@"bookName":model.name,
                                 @"bookType":[NSNumber numberWithInteger:model.novelType],
                                 @"content":model.introduction,
                                 @"bookImage":@"",
                                 @"readType":[NSNumber numberWithInteger:model.viewerType],
                                 @"writeType":[NSNumber numberWithInteger:model.renewPeople],
                                 @"writeNum":@0,
                                 };
    [manager PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"%@",dict[@"message"]);
        NSLog(@"%@",dict[@"status"]);
        failBlock(error);
    }];
}

//发布所发起作品的开头
-(void)publishNovelWithBookId:(NSInteger)bookId chapterTitle:(NSString *_Nullable)chapterTitle content:(NSString *_Nonnull)content success:(successBlock _Nonnull)successBlock fail:(failBlock _Nonnull)failBlock{
    NOVDataModel *datamodel = [NOVDataModel shareInstance];
    NSString *token = [NSString stringWithFormat:@"Bearer %@",[datamodel getToken]];
    NSLog(@"token:%@",token);
    NSString *url = @"http://47.95.207.40/branch/branch";
    NSDictionary *parameters = @{@"bookId":[NSNumber numberWithInteger:bookId],
                                 @"parentId":@0,
                                 @"title":chapterTitle,
                                 @"content":content
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"%@",dict[@"message"]);
        NSLog(@"%@",dict[@"status"]);
        failBlock(error);
    }];
}

@end
