//
//  NOVStartManager.h
//  小说
//
//  Created by 李飞艳 on 2018/6/5.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NOVMystartModel;

typedef void(^successBlock)(id _Nonnull responseObject);

typedef void(^failBlock)(NSError *_Nonnull error);

@interface NOVStartManager : NSObject

-(void)startNovelWithModel:(NOVMystartModel *_Nullable)model success:(successBlock _Nonnull)successBlock fail:(failBlock _Nonnull)failBlock;

-(void)publishNovelWithBookId:(NSInteger)bookId chapterTitle:(NSString *_Nullable)chapterTitle content:(NSString *_Nonnull)content success:(successBlock _Nonnull)successBlock fail:(failBlock _Nonnull)failBlock;

@end
