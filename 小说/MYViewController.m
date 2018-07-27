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
#import "NOVEditUserMessageViewController.h"
#import "NOVPersonalMessage.h"
#import "NOVSignModel.h"
//#import "NOVDataModel.h"

@interface MYViewController ()<NOVSelectPhotoManagerDeleagte>
@property(nonatomic,strong) NOVSelectPhotoManager *photoManager;
@property(nonatomic,strong) NOVMyView *myView;
@property(nonatomic,strong) NOVUserMessage *userMessage;
@end

@implementation MYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _myView = [[NOVMyView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_myView];

    [_myView.headview.myImageButton addTarget:self action:@selector(changeMyimage) forControlEvents:UIControlEventTouchUpInside];
    [_myView.headview.profileButton addTarget:self action:@selector(editUserMessage) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    NOVSignModel *signModel = [[NOVSignModel alloc] init];
    [signModel getUserMessageSuccess:^(id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        _userMessage = [[NOVUserMessage alloc] initWithDictionary:responseObject[@"data"] error:nil];
        _userMessage.simpleUserMessage = [[NOVSimpleUseMessage alloc] initWithDictionary:responseObject[@"data"][@"simpleUserMessage"] error:nil];
        _userMessage.userMessage = [[NOVPersonalMessage alloc] initWithDictionary:responseObject[@"data"][@"userMessage"] error:nil];
        if (![_userMessage.userMessage.signText  isEqual: @""]) {
            [self.myView.headview.profileButton setTitle:[NSString stringWithFormat:@"简介:%@",_userMessage.userMessage.signText] forState:UIControlStateNormal];
        }
        self.myView.headview.nameLabel.text = _userMessage.simpleUserMessage.username;
        [NOVDataModel updateUserMessage:_userMessage];
    } failure:^(NSError * _Nonnull error) {
    }];
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

-(void)editUserMessage{
    NOVEditUserMessageViewController *editUserMessageViewController = [[NOVEditUserMessageViewController alloc] init];
    editUserMessageViewController.hidesBottomBarWhenPushed = YES;
    editUserMessageViewController.userMessage = _userMessage;
    __block MYViewController *weakSelf = self;
    editUserMessageViewController.userMessageBlock = ^(NOVUserMessage *userMessage) {
        [weakSelf.myView.headview.profileButton setTitle:[NSString stringWithFormat:@"简介:%@",userMessage.userMessage.signText] forState:UIControlStateNormal];
        weakSelf.myView.headview.nameLabel.text = userMessage.simpleUserMessage.username;
    };
    [self.navigationController pushViewController:editUserMessageViewController animated:NO];
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
