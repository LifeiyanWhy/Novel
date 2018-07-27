//
//  NOVRecordModel.m
//  小说
//
//  Created by 李飞艳 on 2018/7/23.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVRecordModel.h"
#import "NOVChapterModel.h"
#import "NOVReadParser.h"
#import "NOVReadConfig.h"
#import "NOVDataModel.h"

@implementation NOVChapterReadModel

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.chapterTitle = [aDecoder decodeObjectForKey:@"chapterTitle"];
        self.chapterId = [aDecoder decodeIntegerForKey:@"chapterId"];
        self.chapterNumber = [aDecoder decodeIntegerForKey:@"chapterNumber"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.chapterTitle forKey:@"chapterTitle"];
    [aCoder encodeInteger:self.chapterId forKey:@"chapterId"];
    [aCoder encodeInteger:self.chapterNumber forKey:@"chapterNumber"];
}

@end

@implementation NOVRecordModel

-(instancetype)init{
    self = [super init];
    if (self) {
        _pageArray = [NSMutableArray array];
    }
    return self;
}

+(NOVRecordModel *)getRecordModelFromLocalWithBookId:(NSInteger)bookId{
    NSString *account = [NOVDataModel getUserAccount];
    NOVDataBase *dataBase = [NOVDataBase shareInstance];
    NOVRecordModel *recordModel = [dataBase getUserReadRecordWithAccount:account bookId:bookId];
    if (recordModel != NULL) {
        return recordModel;
    }
    return NULL;
}

//当前阅读章节发生变化,更新pageArray
-(void)updateChapterModel:(NOVChapterModel *)chapterModel{
    _chapterModel = chapterModel;
    [self pagingWithContent:_chapterModel.content bounds:CGRectMake(LeftSpacing, TopSpacing, [UIScreen mainScreen].bounds.size.width-LeftSpacing - RightSpacing,[UIScreen mainScreen].bounds.size.height - TopSpacing - BottomSpacing)];
    
    NOVChapterReadModel *chapterReadModel = [[NOVChapterReadModel alloc] init];
    chapterReadModel.chapterTitle = _chapterModel.title;
    chapterReadModel.chapterId = _chapterModel.branchId;
    chapterReadModel.chapterNumber = _chapter;
    self.page = 0;
    [_chapterArray addObject:chapterReadModel];//添加到已阅读章节的数组中
}

+(void)updateLocalRecordModel:(NOVRecordModel *)recordModel{
    NSString *account = [NOVDataModel getUserAccount];
//    NSLog(@"account%@",account);
    NOVDataBase *dataBase = [[NOVDataBase alloc] init];
    [dataBase updateUserReadRecordWithUserAccount:account record:recordModel];
}

-(void)pagingWithContent:(NSString *)content bounds:(CGRect)bounds{
    if (!content) {
        return;
    }
    [_pageArray removeAllObjects];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString  alloc] initWithString:content];
    NSDictionary *attribute = [NOVReadParser parserAttribute:[NOVReadConfig shareInstance]];
    //设置文本属性
    [attrString setAttributes:attribute range:NSMakeRange(0, attrString.length)];
    //根据文本属性配置CTFramesetterRef
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef) attrString);
    //设置坐标位置
    CGPathRef path = CGPathCreateWithRect(bounds, NULL);
    int currentOffset = 0;
    int currentInnerOffset = 0;
    BOOL hasMorePages = YES;
    // 防止死循环，如果在同一个位置获取CTFrame超过2次，则跳出循环
    int preventDeadLoopSign = currentOffset;
    int samePlaceRepeatCount = 0;
    while (hasMorePages) {
        if (preventDeadLoopSign == currentOffset) {
            ++samePlaceRepeatCount;
        } else {
            samePlaceRepeatCount = 0;
        }
        if (samePlaceRepeatCount > 1) {
            // 退出循环前检查一下最后一页是否已经加上
            if (_pageArray.count == 0) {//如果是第一页
                [_pageArray addObject:@(currentOffset)];
            }
            else {
                NSUInteger lastOffset = [[_pageArray lastObject] integerValue];
                if (lastOffset != currentOffset) {    //没有显示到文本尾，当前位置是最后一页
                    [_pageArray addObject:@(currentOffset)];    //添加最后一页
                }
            }
            break;
        }
        [_pageArray addObject:@(currentOffset)];
        //
        CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(currentInnerOffset, 0), path, NULL);
        //返回实际适合于CTFrameRef字符长度
        CFRange range = CTFrameGetVisibleStringRange(frame);
        if ((range.location + range.length) != attrString.length) {
            currentOffset += range.length;
            currentInnerOffset += range.length;
            
        } else {
            // 已经分完，提示跳出循环
            hasMorePages = NO;
        }
        if (frame) CFRelease(frame);
    }
    
    CGPathRelease(path);
    CFRelease(frameSetter);
    _pageCount = _pageArray.count;
//    NSLog(@"pageCount%ld",(long)_pageCount);
}

//从当前阅读章节(_chapterModel.content)根据页码获取要显示的内容
-(NSString *)stringWithPage:(NSInteger)page{
    NSUInteger local = [_pageArray[page] integerValue];
    NSUInteger length;
    if (page < self.pageCount-1) {
        length =  [_pageArray[page+1] integerValue] - [_pageArray[page] integerValue];
    }
    else{   //已经到最后一页
        length = _chapterModel.content.length - [_pageArray[page] integerValue];
    }
    return [_chapterModel.content substringWithRange:NSMakeRange(local, length)];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.chapterArray = [aDecoder decodeObjectForKey:@"chapterArray"];
        self.chapterModel = [aDecoder decodeObjectForKey:@"chapterModel"];
        self.chapter = [aDecoder decodeIntegerForKey:@"chapter"];
        self.page = [aDecoder decodeIntegerForKey:@"page"];
        self.bookId = [aDecoder decodeIntegerForKey:@"bookId"];
        self.pageCount = [aDecoder decodeIntegerForKey:@"pageCount"];
        self.pageArray = [aDecoder decodeObjectForKey:@"pageArray"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.chapterArray forKey:@"chapterArray"];
    [aCoder encodeObject:self.chapterModel forKey:@"chapterModel"];
    [aCoder encodeInteger:self.chapter forKey:@"chapter"];
    [aCoder encodeInteger:self.page forKey:@"page"];
    [aCoder encodeInteger:self.bookId forKey:@"bookId"];
    [aCoder encodeInteger:self.pageCount forKey:@"pageCount"];
    [aCoder encodeObject:self.pageArray forKey:@"pageArray"];
}

@end
