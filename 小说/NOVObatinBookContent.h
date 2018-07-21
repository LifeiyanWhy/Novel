//
//  NOVObatinBookContent.h
//  小说
//
//  Created by 李飞艳 on 2018/6/27.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^succeedBlock)(id responseObject);
typedef void(^failBlock)(NSError* error);

@interface NOVObatinBookContent : NSObject

//获取书的内容
-(void)ObtainBookContenWithBranchId:(NSInteger)branchId succeed:(succeedBlock)succeedBlock fail:(failBlock)failBlock;

//获取章节信息
-(void)ObtainChapterWithBookId:(NSInteger)bookId ParentId:(NSInteger)parentId succeed:(succeedBlock)succeedBlock fail:(failBlock)failBlock;

//关注一本书
-(void)followBookWithBookId:(NSInteger)bookId succeed:(succeedBlock)succeedBlock fail:(failBlock)failBlock;

-(void)cancelFollowBookId:(NSInteger)bookId succeed:(succeedBlock)succeedBlock fail:(failBlock)failBlock;

//获取首段ID
-(void)getBookFirstChapterIdWithBookID:(NSInteger)bookId succeed:(succeedBlock)succeedBlock fail:(failBlock)failBlock;

@end
