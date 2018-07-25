//
//  NOVRecordModel.h
//  小说
//
//  Created by 李飞艳 on 2018/7/23.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class NOVChapterModel;

@interface NOVChapterReadModel : NSObject<NSCoding>
@property(nonatomic,strong) NSString *chapterTitle; //章节名称
@property(nonatomic,assign) NSInteger chapterId;    //章节ID
@property(nonatomic,assign) NSInteger chapterNumber;    //章节次序
@end

//记录阅读状态，包括所有浏览过的章节
@interface NOVRecordModel : NSObject<NSCoding>
@property(nonatomic,strong) NSMutableArray <NOVChapterReadModel *>*chapterArray;//记录阅读过的章节
@property(nonatomic,assign) NSInteger bookId;
@property(nonatomic,strong) NOVChapterModel *chapterModel;//正在阅读的章节
@property(nonatomic,assign) NSInteger chapter;//章节次序
@property(nonatomic,strong) NSMutableArray *pageArray;//分页
@property(nonatomic,assign) NSInteger page;//阅读位置,即当前页码
@property(nonatomic,assign) NSInteger pageCount;//页数
-(NSString *)stringWithPage:(NSInteger)page;//根据页码取出对应的字符串
+(void)updateLocalRecordModel:(NOVRecordModel*)recordModel;
+(NOVRecordModel *)getRecordModelFromLocalWithBookId:(NSInteger)bookId;
-(void)updateChapterModel:(NOVChapterModel *)chapterModel;//更新章节信息
@end
