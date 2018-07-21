//
//  NOVEditViewController.h
//  小说
//
//  Created by 李飞艳 on 2018/5/10.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NOVMystartModel;

typedef void(^novelTitleBlock)(NOVMystartModel *model);

@interface NOVEditViewController : UIViewController

@property(nonatomic,copy) novelTitleBlock novelTitleBlock;

@end
