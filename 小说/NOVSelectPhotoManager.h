//
//  NOVSelectPhotoManager.h
//  小说
//
//  Created by 李飞艳 on 2018/6/2.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol NOVSelectPhotoManagerDeleagte <NSObject>

@optional

-(void)changeImageWithImage:(UIImage *)image;

@end

@interface NOVSelectPhotoManager : NSObject<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(nonatomic,weak) id<NOVSelectPhotoManagerDeleagte> deleagte;

-(instancetype)initWithViewController:(UIViewController *)viewController;


//从相册中选取
-(void)selectImageWithAlbum;

//拍照
-(void)selectImageWithCamera;

@end
