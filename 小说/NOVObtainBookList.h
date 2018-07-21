//
//  NOVObtainBookList.h
//  小说
//
//  Created by 李飞艳 on 2018/6/26.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, NOVObtainListType){   //获取列表的类型
    NOVObtainBookListRecommend = 1, //今日推荐
    NOVObtainBookListRanking,    //排行榜
};

typedef void(^succeedBlock)(id responseObject);

typedef void(^failBlock)(NSError*  error);

@interface NOVObtainBookList : NSObject

-(void)obtainBookListWithType:(NOVObtainListType)listType succeed:(succeedBlock)succeedBlock fail:(failBlock)failBlock;

@end
