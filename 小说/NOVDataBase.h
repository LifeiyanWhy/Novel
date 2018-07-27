//
//  NOVDataBase.h
//  小说
//
//  Created by 李飞艳 on 2018/7/27.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NOVRecordModel;

@interface NOVDataBase : NSObject
+(NOVDataBase *)shareInstance;
-(void)updateUserReadRecordWithUserAccount:(NSString *)account record:(NOVRecordModel *)recordModel;
-(NOVRecordModel *)getUserReadRecordWithAccount:(NSString *)account bookId:(NSInteger)bookId;
@end
