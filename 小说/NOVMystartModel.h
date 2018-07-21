//
//  NOVMystartModel.h
//  小说
//
//  Created by 李飞艳 on 2018/5/23.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIImage+AFNetworking.h>


//发起类型
typedef NS_OPTIONS(NSInteger, NOVStartType){
    //续写
    NOVStartTypeStartRenew = 0,
    //根据背景扩展
    NOVStartTypeBackgroundExtension,
};

//作品权限
typedef NS_OPTIONS(NSInteger, NOVJurisdiction){
    //公开
    NOVJurisdictionPublic = 0,
    //粉丝可见
    NOVJurisdictionFans,
    //好友可见
    NOVJurisdictionFriend,
    //私有，指定可见人员
    NOVJurisdictionPrivate,
};

//作品类型
typedef NS_OPTIONS(NSInteger, NOVType) {
    NOVTypenovel = 0,
};

@interface NOVMystartModel : NSObject

//图片
@property(nonatomic,strong) UIImage *bookImage;
//@property(nonatomic,strong) NSString *imageUrl;

//作品名称
@property(nonatomic,strong) NSString *name;

//发起形式
@property(nonatomic,assign) NOVStartType startType;

//作品简介
@property(nonatomic,strong) NSString *introduction;

//作品类型
@property(nonatomic,assign) NOVType novelType;

//续写人员
@property(nonatomic,assign) NOVJurisdiction renewPeople;

//可观看人群
@property(nonatomic,assign) NOVJurisdiction viewerType;

@end
