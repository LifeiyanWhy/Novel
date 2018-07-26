//
//  NOVEditSignViewController.h
//  小说
//
//  Created by 李飞艳 on 2018/7/26.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TextSign)(NSString *textSign);
@interface NOVEditSignViewController : UIViewController
@property(nonatomic,strong) TextSign textsign;
@end
