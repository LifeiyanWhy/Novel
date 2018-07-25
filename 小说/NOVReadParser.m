//
//  NOVReadParser.m
//  小说
//
//  Created by 李飞艳 on 2018/7/23.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVReadParser.h"
#import "NOVReadConfig.h"

@implementation NOVReadParser

+(CTFrameRef)loadParserWithContent:(NSString *)content config:(NOVReadConfig *)config bounds:(CGRect)bounds{
    if (!content) {
        return NULL;
    }
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:content];
    //设置文本内容，属性
    [attString addAttributes:[self parserAttribute:config] range:NSMakeRange(0, content.length)];
    //根据文本以及文本属性配置CTFramesetterRef
    CTFramesetterRef setterRef = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attString);
    //绘制区域
    CGPathRef pathRef = CGPathCreateWithRect(bounds, NULL);
    //
    CTFrameRef frameRef = CTFramesetterCreateFrame(setterRef, CFRangeMake(0, 0), pathRef, NULL);
    CFRelease(setterRef);
    CFRelease(pathRef);//ARC环境下编译器不会自动管理CF对象的内存，需要手动释放
    return frameRef;
}

//根据config生成文本属性
+(NSDictionary *)parserAttribute:(NOVReadConfig *)config{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:config.fontSize];
    dict[NSForegroundColorAttributeName] = config.fontColor;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = config.lineSpace;
    style.alignment = NSTextAlignmentJustified;
    dict[NSParagraphStyleAttributeName] = style;
    return dict;
}

@end
