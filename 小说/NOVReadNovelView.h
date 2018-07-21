//
//  NOVReadNovelView.h
//  小说
//
//  Created by 李飞艳 on 2018/4/21.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NOVReadEditVIew;

@interface NOVReadNovelView : UIView

@property(nonatomic,strong) UILabel *contentLabel;

@property(nonatomic,strong) UIButton *midButton;

- (void)setMenu:(NOVReadEditVIew *)view;

@end
