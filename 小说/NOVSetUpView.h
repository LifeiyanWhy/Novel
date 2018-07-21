//
//  NOVSetUpView.h
//  小说
//
//  Created by 李飞艳 on 2018/4/24.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NOVSetUpViewDelegate <NSObject>

- (void)touchColorButton:(UIButton *)button color:(UIColor *)color;

@end

@interface NOVSetUpView : UIView

@property(nonatomic,weak) id<NOVSetUpViewDelegate> delegate;

@end
