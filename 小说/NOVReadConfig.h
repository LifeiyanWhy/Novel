//
//  NOVReadConfig.h
//  小说
//
//  Created by 李飞艳 on 2018/7/21.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NOVReadConfig : NSObject<NSCoding>
+(instancetype)shareInstance;
@property (nonatomic) CGFloat fontSize;//字体大小
@property (nonatomic) CGFloat lineSpace;//行间距
@property (nonatomic,strong) UIColor *fontColor;//字体颜色
@property (nonatomic,strong) UIColor *theme;//背景颜色
@end
