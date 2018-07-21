//
//  MYViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/3/29.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "MYViewController.h"
#import "NOVMyView.h"
#import "NOVMyheadView.h"
#import "NOVSelectPhotoManager.h"

@interface MYViewController ()<NOVSelectPhotoManagerDeleagte>

@property(nonatomic,strong) NOVSelectPhotoManager *photoManager;

@property(nonatomic,strong) NOVMyView *myView;

@end

@implementation MYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _myView = [[NOVMyView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_myView];

    [_myView.headview.myImageButton addTarget:self action:@selector(changeMyimage) forControlEvents:UIControlEventTouchUpInside];
    
    
    _actionController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *photographAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //拍照
        [self photograph];
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //从相册中选取
        [self selectFromAlbum];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [_actionController addAction:photographAction];
    [_actionController addAction:albumAction];
    [_actionController addAction:cancelAction];
}

-(void)changeMyimage{
    NSLog(@"changeMyImage");
    [self presentViewController:_actionController animated:YES completion:nil];
}

-(void)photograph{
    if (!_photoManager) {
        _photoManager = [[NOVSelectPhotoManager alloc] initWithViewController:self];
        _photoManager.deleagte = self;
    }
    [_photoManager selectImageWithCamera];
}

-(void)selectFromAlbum{
    if (!_photoManager) {
        _photoManager = [[NOVSelectPhotoManager alloc] initWithViewController:self];
        _photoManager.deleagte = self;
    }
    [_photoManager selectImageWithAlbum];
}

-(void)changeImageWithImage:(UIImage *)image{
    NSLog(@"=====%@",image);
    [_myView.headview.myImageButton setImage:image forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
