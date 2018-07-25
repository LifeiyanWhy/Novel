//
//  NOVReadNovelView.h
//  小说
//
//  Created by 李飞艳 on 2018/4/21.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface NOVReadNovelView : UIView

@property(nonatomic,assign) CTFrameRef frameRef;
@property(nonatomic,strong) NSString *content;

@end
