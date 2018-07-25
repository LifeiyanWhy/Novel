//
//  NOVReadNovelViewController.h
//  小说
//
//  Created by 李飞艳 on 2018/4/20.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NOVbookMessage;
//@class NOVChapterModel;
@class NOVRecordModel;

@interface NOVReadNovelViewController : UIViewController
@property(nonatomic,strong) NOVbookMessage *bookMessage; //要阅读的小说信息
//@property(nonatomic,strong) NOVChapterModel *chapterModel;//当前阅读章节
@property(nonatomic,strong) NOVRecordModel *recordModel;
@end
