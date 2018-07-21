//
//  NOVWriteViewController.h
//  小说
//
//  Created by 李飞艳 on 2018/4/22.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^publishNovelBlock)(NSString *title,NSString *content);

@interface NOVWriteViewController : UIViewController

@property(nonatomic,strong)  publishNovelBlock publishNovelBlock;

@end
