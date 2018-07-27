//
//  NOVUserMessageModel.m
//  小说
//
//  Created by 李飞艳 on 2018/7/26.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVPersonalMessage.h"

@implementation NOVPersonalMessage

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.signText forKey:@"signText"];
    [aCoder encodeObject:self.experience forKey:@"experience"];
    [aCoder encodeObject:self.userGrade forKey:@"userGrade"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.location forKey:@"location"];
    [aCoder encodeObject:self.school forKey:@"school"];
    [aCoder encodeObject:self.company forKey:@"company"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self.signText = [aDecoder decodeObjectForKey:@"signText"];
    self.experience = [aDecoder decodeObjectForKey:@"experience"];
    self.userGrade = [aDecoder decodeObjectForKey:@"userGrade"];
    self.sex = [aDecoder decodeObjectForKey:@"sex"];
    self.location = [aDecoder decodeObjectForKey:@"location"];
    self.school = [aDecoder decodeObjectForKey:@"school"];
    self.company = [aDecoder decodeObjectForKey:@"company"];
    return self;
}

@end

@implementation NOVSimpleUseMessage

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.account forKey:@"account"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self.username = [aDecoder decodeObjectForKey:@"username"];
    self.account = [aDecoder decodeObjectForKey:@"account"];
    return self;
}

@end

@implementation NOVUserMessage

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.simpleUserMessage forKey:@"simpleUserMessage"];
    [aCoder encodeObject:self.userMessage forKey:@"userMessage"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self.simpleUserMessage = [aDecoder decodeObjectForKey:@"simpleUserMessage"];
    self.userMessage = [aDecoder decodeObjectForKey:@"userMessage"];
    return self;
}

@end

@implementation NOVObtainUserMessage

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.data forKey:@"data"];
    [aCoder encodeInteger:self.status forKey:@"status"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self.data = [aDecoder decodeObjectForKey:@"data"];
    self.status = [aDecoder decodeIntegerForKey:@"status"];
    return self;
}

@end
