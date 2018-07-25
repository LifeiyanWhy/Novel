//
//  NOVReadParser.h
//  小说
//
//  Created by 李飞艳 on 2018/7/23.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@class NOVReadConfig;

@interface NOVReadParser : NSObject

+(CTFrameRef)loadParserWithContent:(NSString *)content config:(NOVReadConfig *)config bounds:(CGRect)bounds;
+(NSDictionary *)parserAttribute:(NOVReadConfig *)config;

@end
