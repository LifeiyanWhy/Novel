//
//  NOVChapterModel.m
//  小说
//
//  Created by 李飞艳 on 2018/7/23.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVChapterModel.h"

@implementation NOVChapterAuthor

-(id)copyWithZone:(NSZone *)zone{
    NOVChapterAuthor *author = [[NOVChapterAuthor allocWithZone:zone] init];
    author.account = [self.account mutableCopy];
    author.userId = self.userId;
    author.username = [self.username mutableCopy];
    return author;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.account forKey:@"account"];
    [aCoder encodeInteger:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.username forKey:@"username"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self.account = [aDecoder decodeObjectForKey:@"account"];
    self.userId = [aDecoder decodeIntegerForKey:@"userId"];
    self.username = [aDecoder decodeObjectForKey:@"username"];
    return self;
}
@end

@implementation NOVChapterModel

-(id)copyWithZone:(NSZone *)zone
{
    NOVChapterModel *model = [[NOVChapterModel allocWithZone:zone] init];
    model.content = [self.content mutableCopy];
    model.title = [self.title mutableCopy];
    model.branchId = self.branchId;
    model.author = [self.author copy];
    return model;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeInteger:self.branchId forKey:@"branchId"];
    [aCoder encodeObject:self.author forKey:@"author"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self.content = [aDecoder decodeObjectForKey:@"content"];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.branchId = [aDecoder decodeIntegerForKey:@"branchId"];
    self.author = [aDecoder decodeObjectForKey:@"author"];
    return self;
}

@end
