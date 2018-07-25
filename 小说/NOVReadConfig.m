//
//  NOVReadConfig.m
//  小说
//
//  Created by 李飞艳 on 2018/7/21.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVReadConfig.h"

@implementation NOVReadConfig

+(instancetype)shareInstance{
    static NOVReadConfig *readConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        readConfig = [[self alloc] init];
    });
    return readConfig;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //从本地读取阅读配置信息(字体大小、颜色等)
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"ReadConfig"];
        if (data) {
            //把从本地读取的文件解码
            NSKeyedUnarchiver *unarchive = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
            //为配置属性添加观察者
            NOVReadConfig *config = [unarchive decodeObjectForKey:@"ReadConfig"];
            [config addObserver:config forKeyPath:@"fontSize" options:NSKeyValueObservingOptionNew context:NULL];
            [config addObserver:config forKeyPath:@"lineSpace" options:NSKeyValueObservingOptionNew context:NULL];
            [config addObserver:config forKeyPath:@"fontColor" options:NSKeyValueObservingOptionNew context:NULL];
            [config addObserver:config forKeyPath:@"theme" options:NSKeyValueObservingOptionNew context:NULL];
            return config;
        }
        //如果没有读取到设置默认字体
        _lineSpace = 15.0f;
        _fontSize = 20.0f;
        _fontColor = [UIColor blackColor];
        _theme = [UIColor whiteColor];
        //为配置属性添加观察者
        [self addObserver:self forKeyPath:@"fontSize" options:NSKeyValueObservingOptionNew context:NULL];
        [self addObserver:self forKeyPath:@"lineSpace" options:NSKeyValueObservingOptionNew context:NULL];
        [self addObserver:self forKeyPath:@"fontColor" options:NSKeyValueObservingOptionNew context:NULL];
        [self addObserver:self forKeyPath:@"theme" options:NSKeyValueObservingOptionNew context:NULL];
        //存将阅读配置信息存储到本地
        [NOVReadConfig updateLocalConfig:self];
        
    }
    return self;
}
//当配置属性改变时执行该方法，将改变后的值存储到本地
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [NOVReadConfig updateLocalConfig:self];//存储
}
//更新本地数据
+(void)updateLocalConfig:(NOVReadConfig *)config
{
    NSMutableData *data=[[NSMutableData alloc]init];
    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:config forKey:@"ReadConfig"];
    [archiver finishEncoding];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"ReadConfig"];
}
//编码
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeDouble:self.fontSize forKey:@"fontSize"];
    [aCoder encodeDouble:self.lineSpace forKey:@"lineSpace"];
    [aCoder encodeObject:self.fontColor forKey:@"fontColor"];
    [aCoder encodeObject:self.theme forKey:@"theme"];
}
//解码
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.fontSize = [aDecoder decodeDoubleForKey:@"fontSize"];
        self.lineSpace = [aDecoder decodeDoubleForKey:@"lineSpace"];
        self.fontColor = [aDecoder decodeObjectForKey:@"fontColor"];
        self.theme = [aDecoder decodeObjectForKey:@"theme"];
    }
    return self;
}
@end
