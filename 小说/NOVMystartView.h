//
//  NOVMystartView.h
//  小说
//
//  Created by 李飞艳 on 2018/5/22.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NOVSetView;

@class NOVMystartModel;

@protocol NOVMystartViewDategate <NSObject>

@optional
//点击编辑button时执行
-(void)touchEditButtonInSetView:(NOVSetView *)setView;

@end

@interface NOVMystartView : UIView<UITableViewDelegate>

@property(nonatomic,strong) UIScrollView *scrollView;

@property(nonatomic,weak) id <NOVMystartViewDategate>delegate;

-(void)addViewWithModel:(NOVMystartModel *)model;

@end
