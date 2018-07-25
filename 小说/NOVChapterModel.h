//
//  NOVChapterModel.h
//  小说
//
//  Created by 李飞艳 on 2018/7/23.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <JSONModel/JSONModel.h>

//章节内容

@interface NOVChapterAuthor : JSONModel<NSCopying,NSCoding>
@property(nonatomic,assign) NSInteger userId;
@property(nonatomic,strong) NSString *username;
@property(nonatomic,strong) NSString *account;
@end

@interface NOVChapterModel : JSONModel<NSCopying,NSCoding>
@property(nonatomic,assign) NSInteger branchId;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NOVChapterAuthor *author;
@property(nonatomic,strong) NSString *content;
@end

@interface NOVObtainChapterModel : JSONModel
@property(nonatomic,assign) NSInteger status;
@property(nonatomic,strong) NOVChapterModel *data;
@end
