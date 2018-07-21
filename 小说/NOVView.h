//
//  NOVView.h
//  小说
//
//  Created by 李飞艳 on 2018/4/10.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NOVViewDelegate <NSObject>

@optional

//点击时执行该方法
-(void)touchRespone:(UIButton *)touchButton;

@end

@interface NOVView : UIView

@property(nonatomic,weak) id <NOVViewDelegate> delegate;

@property(nonatomic,strong,readonly) NSArray *titleArray;

-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;

//button.title
-(void)setTitleArray:(NSArray *)titleArray;

//width代表novview对应scrollView的宽度
-(void)setButtonPostion:(CGPoint)point width:(CGFloat)width;

//设置(选中／未选中)文本颜色
-(void)setTitleColor:(UIColor *)titleColor selectedColor:(UIColor *)selectedColor;

@end
