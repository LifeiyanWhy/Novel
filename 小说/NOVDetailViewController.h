//
//  NOVDetailViewController.h
//  小说
//
//  Created by 李飞艳 on 2018/5/14.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^viewTitleBlock)(NSString *viewtitle,NSInteger enumNumber);

//要填写的信息对应view要展示的数据类型
typedef  NS_OPTIONS(NSInteger, viewType){
    startType = 0,  //发起形式
    viewNovelType,  //作品类型
    renewPeople,    //续写人员
    viewerType  //观看人群
};

@interface NOVDetailViewController : UIViewController

@property(nonatomic,assign) viewType viewtype;

@property(nonatomic,strong) NSString *viewtitle;

@property(nonatomic,copy) viewTitleBlock viewtitleBlock;

@end
