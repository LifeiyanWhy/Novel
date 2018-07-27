//
//  NOVDataBase.m
//  小说
//
//  Created by 李飞艳 on 2018/7/27.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVDataBase.h"
#import "fmdb.h"
#import "NOVRecordModel.h"

@implementation NOVDataBase{
    FMDatabase *database;
}

static NOVDataBase *novDataBase = nil;

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        novDataBase = [super allocWithZone:zone];
    });
    return novDataBase;
}

+(NOVDataBase*)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        novDataBase = [[NOVDataBase alloc] init];
        [novDataBase creatDataBase];
    });
    return novDataBase;
}

-(void)creatDataBase{
    NSString *str = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [str stringByAppendingPathComponent:@"userReadRecord.sqlite"]; //用户阅读记录
    database = [[FMDatabase alloc] initWithPath:fileName];
    if ([database open]) {
        NSString *creatTable = @"CREATE TABLE IF NOT EXISTS'userUseInformation'(\
                                userAccount NSString PRIMARY KEY,\
                                readRecordArray NSData\
                                )";
        if ([database executeUpdate:creatTable]) {
            NSLog(@"succeed");
        }else{
            NSLog(@"failure");
        }
    }else{
        NSLog(@"数据库异常");
    }
    [database close];
}

-(void)updateUserReadRecordWithUserAccount:(NSString *)account record:(NOVRecordModel *)recordModel{
    if ([database open]) {
        NSString *string = @"SELECT readRecordArray FROM userUseInformation WHERE userAccount = ?";
        FMResultSet *result = [database executeQuery:string,account];//查找该用户的使用记录
        NSArray *array;
        while ([result next]) {
            array = [NSKeyedUnarchiver unarchiveObjectWithData:[result dataForColumn:@"readRecordArray"]]; //取出原数据
        }
        if (array) {   //在本地找到了该用户的使用记录
            BOOL bookExist = 0;
            NSMutableArray *recordModelArray = [NSMutableArray arrayWithArray:array];
            for (int i = 0; i < array.count; i++) {//查看是否有该书的阅读记录
                NOVRecordModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:array[i]];
                if (model.bookId == recordModel.bookId) {   //已经存在,更新阅读状态
                    [recordModelArray replaceObjectAtIndex:i withObject:[NSKeyedArchiver archivedDataWithRootObject:recordModel]];
                    bookExist = YES;
                    break;
                }
            }
            if (!bookExist) {//不存在，添加
                [recordModelArray addObject:[NSKeyedArchiver archivedDataWithRootObject:recordModel]];//将要添加的数据归档加入数组
            }
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:recordModelArray];//将添加后的数据归档
            NSString *stringUpdate = @"UPDATE  'userUseInformation' SET readRecordArray = ? WHERE userAccount = ?";
            [database executeUpdate:stringUpdate,data,account];
            [database close];
            return;
        }else{  //没有该用户的使用记录则直接添加
            NSMutableArray *recordModelArray = [NSMutableArray arrayWithObject:[NSKeyedArchiver archivedDataWithRootObject:recordModel]];
            NSString *stringInsert = @"INSERT INTO userUseInformation(userAccount,readRecordArray) VALUES(?,?)";
            if (![database executeUpdate:stringInsert,account,[NSKeyedArchiver archivedDataWithRootObject:recordModelArray]]) {
                NSLog(@"failure");
            }
            [database close];
            return;
        }
    } else {
        NSLog(@"数据库打开失败");
    }
    [database close];
}

-(NOVRecordModel *)getUserReadRecordWithAccount:(NSString *)account bookId:(NSInteger)bookId{
    if ([database open]) {
        NSString *string = @"SELECT readRecordArray FROM userUseInformation WHERE userAccount = ?";
        FMResultSet *result = [database executeQuery:string,account];
        NSMutableArray *modelArray;
        while ([result next]) {
            modelArray = [NSKeyedUnarchiver unarchiveObjectWithData:[result dataForColumn:@"readRecordArray"]];
        }
        if (modelArray) {
            for (int i = 0; i < modelArray.count; i++) {
                NOVRecordModel *recordModel = [NSKeyedUnarchiver unarchiveObjectWithData:modelArray[i]];
                if (bookId == recordModel.bookId) {//查找到指定用户指定bookId的阅读记录
                    return recordModel;
                }
            }
        }
    }else{
        NSLog(@"数据库异常");
    }
    return nil;
}
@end
