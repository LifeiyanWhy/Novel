//
//  NOVSignModel.m
//  小说
//
//  Created by 李飞艳 on 2018/5/27.
//  Copyright © 2018年 李飞艳. All rights reserved.
//
/*
 {
 "sid":"fbb3e2102605623bc459eaa58d4e5de2",
 "token":"790e95ea04d1b01d37406fa69a1fb6b2",
 "appid":"f78f604b69394b0e98daf41be63778d3",
 "templateid":"341137",
 "param":"1",
 "mobile":"18710571593"
 }
 */

#import "NOVSignModel.h"
#import <AFNetworking.h>
#import "NOVDataModel.h"

@implementation NOVSignModel

-(void)signUpWithAccount:(NSString *)account username:(NSString *)username passward:(NSString *)password success:(successBlock)successBlock failure:(failBlock)failBlock{
    NSDictionary *parameters = @{@"username":username,
                                 @"account":account,
                                 @"password":password
                                 };
    NSString *urlString = @"http://47.95.207.40/branch/user/register";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *string = [[NSString alloc] initWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
        failBlock(error);
    }];
}

-(void)loginWithAccount:(NSString *_Nonnull)account password:(NSString *_Nonnull)password success:(successBlock _Nullable )successBlock failure:(failBlock _Nullable )failBlock{
    NSDictionary *parameters = @{@"account":account,
                                 @"password":password
                                 };
    NSString *urlString = @"http://47.95.207.40/branch/login";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"Basic YnJhbmNoOnhpeW91M2c=" forHTTPHeaderField:@"Authorization"];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NOVDataModel *datamodel = [NOVDataModel shareInstance];
        //将登录成功后获取到的token存储到沙盒中
        [datamodel updateToken:responseObject[@"access_token"] refreshToken:responseObject[@"refresh_token"]];
        [self updateToken];
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       failBlock(error);
    }];
//    NSLog(@"=====HTTPRequestHeaders:%@",manager.requestSerializer.HTTPRequestHeaders);
}

-(void)updateToken{
    //每两个小时重新获取一次token
    NSTimer *timer = [NSTimer timerWithTimeInterval:7199.0 target:self selector:@selector(token) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

//获取token
-(void)token{
    NOVDataModel *datamodel = [NOVDataModel shareInstance];
    NSString *refresh_token = [datamodel getRefreshToken];
    NSData *refreshData = [refresh_token dataUsingEncoding:NSUTF8StringEncoding];
    NSString *url = @"http://47.95.207.40/branch/oauth/token";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"Basic YnJhbmNoOnhpeW91M2c=" forHTTPHeaderField:@"Authorization"];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    [formData appendPartWithFormData:[@"refresh_token" dataUsingEncoding:NSUTF8StringEncoding] name:@"grant_type"];
    [formData appendPartWithFormData:refreshData name:@"refresh_token"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dict);
        NOVDataModel *datamodel = [NOVDataModel shareInstance];
        //获取到token后更新沙盒中的数据
        [datamodel updateToken:dict[@"access_token"] refreshToken:dict[@"refresh_token"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error%@",error);
    }];
}

//获取关注列表
-(void)obtainFollowList{
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
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *followIdArray = [NSMutableArray array];
        for (NSDictionary *dict in dataArray) {
            [followIdArray addObject:dict[@"bookId"]];
        }
        //存储关注列表
        [datamodel updateFollowBookListWithArray:followIdArray];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"%@",dict);
    }];
}
@end


/*
 NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://47.95.207.40/branch/user/register]];
 NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
 request.HTTPMethod = @"post";
 NSString *message = [NSString stringWithFormat:@"username=%@&account=%@&password=%@",@"lifeiyan",@"12345678910",@"123456"];
 request.HTTPBody = [message dataUsingEncoding:NSUTF8StringEncoding];
 NSURLSession *session = [NSURLSession sharedSession];
 NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
 NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
 NSLog(@"====%@",dict);
 if (error) {
 NSLog(@"%@",error);
 }
 }];
 [dataTask resume];
 */
