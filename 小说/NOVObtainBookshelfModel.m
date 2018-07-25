//
//  NOVObtainBookshelfModel.m
//  小说
//
//  Created by 李飞艳 on 2018/7/21.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVObtainBookshelfModel.h"
#import "NOVDataModel.h"
#import <AFNetworking.h>
@implementation NOVObtainBookshelfModel

-(void)obtainFollowBookListSucceed:(successBlock)succeedBlock failure:(failBlock)failBlock{
    NOVDataModel *datamodel = [NOVDataModel shareInstance];
    NSString *token = [NSString stringWithFormat:@"Bearer %@",[datamodel getToken]];
    NSLog(@"token=%@",token);
    NSString *url = @"http://47.95.207.40/branch/user/book";
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    [manger.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manger GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject[@"data"]);
        succeedBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code == -1009) {
            NSLog(@"1009");
        }else{
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:&error];
            NSLog(@"%@",dict);
            failBlock(error);
        }
    }];
}

@end
