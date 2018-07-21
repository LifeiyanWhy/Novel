//
//  NOVSelectPhotoManager.m
//  小说
//
//  Created by 李飞艳 on 2018/6/2.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVSelectPhotoManager.h"

@implementation NOVSelectPhotoManager{
    UIViewController *presentController;
}

-(instancetype)initWithViewController:(UIViewController *)viewController{
    self = [super init];
    if (self) {
        presentController = viewController;
    }
    return self;
}

-(void)selectImageWithAlbum{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    //允许编辑
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if (presentController) {
        //跳转到选择图片界面
        [presentController presentViewController:imagePickerController animated:YES completion:nil];
    }
}

-(void)selectImageWithCamera{
    if (![UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
        NSLog(@"no camera");
        return;
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"=====%@",info);
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    if (!image) {
        image = info[@"UIImagePickerControllerOriginalImage"];
    }
    if (_deleagte && [_deleagte respondsToSelector:@selector(changeImageWithImage:)]) {
        [self.deleagte changeImageWithImage:image];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}



@end
